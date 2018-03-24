class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :destroy, :change_status, :compare_bids]
  before_action :set_company
  before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]

  # GET /requests
  # GET /requests.json
  def index

    if current_user.supplier.nil?
      if Supplier.where(email: current_user.email).exists?
        current_user.supplier = Supplier.where(email: current_user.email).first
      end
    end
    
    unless current_company.nil?
      @ended_requests = []
      @active_requests = []
      
      if current_company.owner == current_user
        @requests = current_company.requests.where(folder_id: 1)
        @closed_requests  =  current_company.requests.where(folder_id: 2)
        @archived_requests  =  current_company.requests.where(folder_id: 3)
      else 
        @requests = current_company.requests.where(:user_id => current_user.id).where(folder_id: 1)
        @closed_requests    =  current_company.requests.where(:user_id => current_user.id).where(folder_id: 2)
        @archived_requests  =  current_company.requests.where(:user_id => current_user.id).where(folder_id: 3)
      end 

      @requests.each do |request|
        if Time.now > request.end_time
          @ended_requests << request
        else
          @active_requests << request
        end
      end    

      if current_company.owner == current_user
        @requests = current_company.requests
      else
        @requests = current_company.requests.where(:user_id => current_user.id)
      end 

    else
      @requests = {}
    end 
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @suppliers = @request.suppliers
  end

  # GET /requests/new
  def new
    if current_company.nil?
      flash[:notice] = 'You need to set company before creating request.'
      redirect_to new_company_path
    else
      @request = Request.new
      unless params[:requisition_id].nil?
        @requisition                = Requisition.find params[:requisition_id]
        @request.name               = @requisition.name
        @request.end_time           = @requisition.delivery_date
        @request.description        = @requisition.description
        @request.expected_budget    = @requisition.budget
        @request.preferred_currency = @requisition.budget_currency
      end 
      @type    = params[:format]
    end   
  end

  # GET /requests/1/edit
  def edit
    @type = @request.request_type
    if @type == 'RFQ'
      @items = @request.items
    end
    @questions = @request.questions
    @priority = params[:priority]
  end

  # POST /requests
  # POST /requests.json
  def create

    if participant_params.nil? or item_params.empty? or question_params.empty?

      flash[:error] = 'You need to add at least one participiant, item list and questionaire.'
      redirect_back fallback_location: new_request_url

    else

      @request = Request.new(request_params)

      respond_to do |format|
        if @request.save

          unless item_params.empty?
            JSON.parse(item_params.to_s).each do |item|
              @request.items.create!(item)
            end
          end

          unless question_params.empty?
            JSON.parse(question_params.to_s).each do |question|
              @request.questions.create!(question)
            end
          end

          unless participant_params.empty?

            participant_params.each do |participant|
              supplier = Supplier.find_or_create_by(email: participant)
              @request.suppliers << supplier
              if User.where(email: supplier.email).exists?
                supplier.update( user_id: User.where(email: supplier.email).first.id )
              end
              TenderBooksNotifierMailer.invite_supplier(supplier, @request).deliver_later
              TenderBooksNotifierMailer.invite_notifier(current_user, supplier, @request).deliver_later
              @request.messages.create!(
                from: 'buyer',
                read: false,
                user_id: current_user.id, 
                supplier_id: supplier.id,
                content: 'Please apply...'
                )
            end

          end

          unless request_params[:requisition_id].nil?
            TenderBooksNotifierMailer.create_request_company(@request).deliver_later
            TenderBooksNotifierMailer.create_request_requisitioner(@request).deliver_later
            @request.requisition.update!( status: 'tendering' )
          end

          unless category_params.empty?
            @request.categories.clear
            category_params.each do |category_id|
              unless category_id == ''
                category = Category.find(category_id)
                category.requests << @request
              end
            end                    
          end        
          
          format.html { redirect_to requests_path, notice: 'Request was successfully created.' }
          format.json { render :show, status: :created, location: requests_path }
        else
          format.html { render :new }
          format.json { render json: @request.errors, status: :unprocessable_entity }
        end
      end

    end    

  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)

          if request_params.has_key? 'extend_reason'

            @request.suppliers.each do |supplier|
              TenderBooksNotifierMailer.update_supplier(supplier, @request, true).deliver_later
              @request.messages.create!(
                from: 'buyer',
                read: false,
                user_id: current_user.id, 
                supplier_id: supplier.id,
                content: "Closing time was extended with the reason:<br> <b>#{@request.extend_reason}</b>.<br> please review..."
                )
            end

            format.html { redirect_to @request, notice: 'Closing time was successfully extended.' }
            format.json { render :show, status: :ok, location: @request }

          elsif request_params.has_key? 'clarificatoin'

            unless item_params.empty?
              
              JSON.parse(item_params.to_s).each_with_index do |item, index|
                unless @request.items[index].nil?
                  @request.items[index].update!(item)
                else
                  @request.items.create!(item)
                end              
              end
              
              unless JSON.parse(item_params.to_s).count > @request.items.count
                @request.items.each_with_index do |item, index|
                  if index >= JSON.parse(item_params.to_s).count
                    item.destroy
                  end
                end
              end

            end

            unless question_params.empty?
              
              JSON.parse(question_params.to_s).each_with_index do |question, index|
                @request.questions.create!(question)
                unless @request.questions[index].nil?
                  @request.questions.update!(question)
                else
                  @request.questions.create!(question)
                end
              end
              
              unless JSON.parse(question_params.to_s).count > @request.items.count
                @request.questions.each_with_index do |question, index|
                  if index >= JSON.parse(question_params.to_s).count
                    item.destroy
                  end
                end
              end

            end

            # unless participant_params.nil?

            #   unless participant_params.empty?

            #     participant_params.each do |participant|

            #       supplier = Supplier.find_or_create_by(email: participant)
                  
            #       unless @request.suppliers.include? supplier
            #         @request.suppliers << supplier
            #         if User.where(email: supplier.email).exists?
            #           supplier.update( user_id: current_user.id )
            #         end
            #         TenderBooksNotifierMailer.update_supplier(supplier, @request).deliver_later
            #         @request.messages.create!(
            #           from: 'buyer',
            #           read: false,
            #           user_id: current_user.id, 
            #           supplier_id: supplier.id,
            #           content: 'Request updated, please review and make a bid again...'
            #           )
            #       end

            #     end
            #   end 

            # end
            unless category_params.empty?
              @request.categories.clear
              category_params.each do |category_id|
                unless category_id.empty?
                  category = Category.find(category_id)
                  category.requests << @request
                end
              end                    
            end  

            @request.suppliers.each do |supplier|
              TenderBooksNotifierMailer.update_supplier(supplier, @request, nil).deliver_later
              @request.messages.create!(
                from: 'buyer',
                read: false,
                user_id: current_user.id, 
                supplier_id: supplier.id,
                content: "Request updated with the clarification:<br> <b>#{@request.clarificatoin}</b>.<br> please review and make a bid again..."
                )
            end


          format.html { redirect_to @request, notice: 'Request was successfully updated.' }
          format.json { render :show, status: :ok, location: @request }

        end

      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    status = params[:status]
    folder = Folder.find status.to_i
    respond_to do |format|
      @request.folder = folder
      if @request.save!
        if status == '2'
          @request.update!(cancel_reason: params[:cancel_reason])
          notice = 'Request was successfully closed. You can\'t open request again anymore.'
          TenderBooksNotifierMailer.close_request_buyer(@request.user, @request).deliver_later
          @request.suppliers.each do |supplier|
            TenderBooksNotifierMailer.close_request_supplier(@request.user, supplier, @request).deliver_later
            @request.messages.create!(
              from: 'buyer',
              read: false,
              user_id: current_user.id, 
              supplier_id: supplier.id,
              content: "Request was closed with the reason:<br> <b>#{@request.cancel_reason}</b>..."
              )
          end
        else
          notice = 'Request was successfully archieved.'
        end 
        format.html { redirect_to @request, notice: notice }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { redirect_to @request, notice: 'There was an error to assign.' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_request
    request = Request.find assign_params[:request]
    buyer   = User.find assign_params[:buyer]
    respond_to do |format|
      request.user = buyer
      if request.save!
        TenderBooksNotifierMailer.assign_request_buyer(buyer, request).deliver_later
        request.suppliers.each do |supplier|
          TenderBooksNotifierMailer.assign_request_supplier(buyer, supplier, request).deliver_later
          request.messages.create!(
            from: 'buyer',
            read: false,
            user_id: current_user.id, 
            supplier_id: supplier.id,
            content: "Request was assigned to #{buyer.name}"
            )
        end
        format.html { redirect_to request, notice: "Request for #{request.name} was successfully assigned to #{buyer.name}." }
        format.json { render :show, status: :ok, location: request }
      else
        format.html { redirect_to request, notice: 'There was an error to assign.' }
        format.json { render json: request.errors, status: :unprocessable_entity }
      end
    end
  end

  def compare_bids
    @total_bids = @request.bids
    @bids       = @request.bids.group_by(&:supplier)    
  end

  def set_winner
    request = Request.find winner_params[:request_id]
    win_bid = Bid.find winner_params[:winner_id]
    winner_subject = winner_params[:subject1]
    failer_subject = winner_params[:subject2]
    winner_content = winner_params[:content1]
    failer_content = winner_params[:content2]
    
    respond_to do |format|
      
      if request.update( folder_id: 2 )
        request.bids.each do |bid|
          if bid == win_bid
            TenderBooksNotifierMailer.set_winner_supplier(request, bid.supplier, winner_subject, winner_content).deliver_later
            bid.update!(status: 'win')
            request.messages.create!(
              from: 'buyer',
              read: false,
              user_id: current_user.id, 
              supplier_id: bid.supplier.id,
              content: "Hey, #{bid.supplier.email}, #{winner_subject}"
              )
          else
            TenderBooksNotifierMailer.set_winner_supplier(request, bid.supplier, failer_subject, failer_content).deliver_later
          end 
        end
        format.html { redirect_to request_url(request.id), notice: 'The winner was successfully set.' }
        format.json { render json: {  status: 'success', message: 'The winner was successfully set.' } }
      else
        format.html { redirect_to compare_bids_url(request.id), error: 'There was an error to set winner.' }
        format.json { render json: {  status: 'error', message: 'There was an error to set winner' } }
      end

    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(
        :name, 
        :end_time, 
        :description, 
        :attach,
        :permission,
        :total_price_must,
        :allow_alternative_bids,
        :sealed_bids,
        :preferred_currency,
        :expected_budget,
        :user_id, 
        :company_id, 
        :folder_id, 
        :request_type,
        :requisition_id,
        :procuring_entity,
        :submission_type,
        :bidder_fee,
        :bid_bond,
        :special_remarks,
        :extend_reason,
        :clarificatoin
        )
    end

    def item_params
      params[:request_items]
    end

    def question_params
      params[:request_questions]
    end

    def participant_params
      params[:participants]
    end

    def set_company
      if current_user.companies.exists?
        session[:current_company_id] = current_user.companies.first.id if session[:current_company_id].nil?
      else
        session[:current_company_id] = 0
      end 
    end

    def assign_params
      params.require(:assign).permit(:request, :buyer )
    end

    def winner_params
      params.require(:winner).permit(:request_id, :winner_id, :subject1, :subject2, :content1, :content2)
    end

    def category_params
      params[:request][:categories]
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "requests/#{current_user.id}/#{Time.now.strftime("%Y%m%d%H%M")}/${filename}", success_action_status: '201', acl: 'public-read')
    end

  end
