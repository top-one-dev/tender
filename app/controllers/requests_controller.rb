class RequestsController < ApplicationController
  before_action :authenticate_user!, :except => [:delete_document]
  before_action :set_request, only: [:show, :edit, :update, :destroy, :change_status, :compare_bids, :export_excel, :pdf, :download, :invite_supplier]
  before_action :set_company, :except => [:delete_document]
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
        @requests           = current_company.requests.where(folder_id: 1)
        @closed_requests    = current_company.requests.where(folder_id: 2)
        @under_reg_requests = current_company.requests.where(folder_id: 4)
        @archived_requests  = current_company.requests.where(folder_id: 3)
      else 
        @requests           = current_company.requests.where(:user_id => current_user.id).where(folder_id: 1)
        @closed_requests    = current_company.requests.where(:user_id => current_user.id).where(folder_id: 2)
        @under_reg_requests = current_company.requests.where(:user_id => current_user.id).where(folder_id: 4)
        @archived_requests  = current_company.requests.where(:user_id => current_user.id).where(folder_id: 3)
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

    elsif !session[:request_params].nil?

      @request = Request.new(session[:request_params])
      unless session[:item_params].empty?
        JSON.parse(session[:item_params].to_s).each do |item|
          @request.items.build(item)
        end
      end

      unless session[:question_params].empty?
        JSON.parse(session[:question_params].to_s).each do |question|
          @request.questions.build(question)
        end
      end

      @items            = @request.items
      @questions        = @request.questions
      @type             = @request.request_type
      @item_params      = session[:item_params]
      @question_params  = session[:question_params]
      @categories       = session[:category_params]
      @participants     = []
      unless session[:participants].nil?
        session[:participants].each do |participant|
          if Supplier.where(email: participant).exists?
            @participants << Supplier.where(email: participant).first
          else
            @participants << Supplier.new(email: participant)
          end
        end
      end      

      session[:request_params]  = nil
      session[:item_params]     = nil
      session[:question_params] = nil
      session[:participants]    = nil

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
    if @type != 'RFI'
      @items          = @request.items
      @item_params    = @items.collect{|i| {  'name':         i.name, 
        'unit':         i.unit, 
        'quantity':     i.quantity, 
        'description':  i.description} }
        @item_params    = @item_params.to_json
      end
      @questions        = @request.questions
      @question_params  = @questions.collect{|q| {  'title':          q.title, 
        'description':    q.description, 
        'question_type':  q.question_type, 
        'options':        q.options,
        'enable_attatch': q.enable_attatch,
        'mandatory':      q.mandatory} }
        @categories       = @request.categories.collect{ |c| c.id }
        @participants     = @request.suppliers
        @question_params  = @question_params.to_json
        if params.has_key? 'priority'
          @priority         = params[:priority]
        end
      end

  # POST /requests
  # POST /requests.json
  def create
  	if ( request_params['folder_id'].to_i == 1 ) and ( participant_params.nil? or item_params.empty? or question_params.empty? )

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

          unless participant_params.nil?

            unless participant_params.empty?

              participant_params.each do |participant|
                supplier = Supplier.find_or_create_by(email: participant)
                @request.suppliers << supplier
                if User.where(email: supplier.email).exists?
                  supplier.update( user_id: User.where(email: supplier.email).first.id )
                end
                if request_params['folder_id'].to_i == 1
                  TenderBooksNotifierMailer.invite_supplier(supplier, @request).deliver_later
                  @request.messages.create!(
                    from: 'buyer',
                    read: false,
                    user_id: current_user.id,
                    supplier_id: supplier.id,
                    content: 'Please apply...'
                    )
                end
              end

              TenderBooksNotifierMailer.invite_notifier(current_user, @request).deliver_later

            end

          end

          unless request_params[:requisition_id].nil? 
            if request_params['folder_id'] == 1
              TenderBooksNotifierMailer.create_request_company(@request).deliver_later
              TenderBooksNotifierMailer.create_request_requisitioner(@request).deliver_later
              @request.requisition.update!( status: 'tendering' )
            end
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

        else

          unless item_params.empty?


            unless JSON.parse(item_params.to_s).count > @request.items.count
              @request.items.each_with_index do |item, index|
                if index >= JSON.parse(item_params.to_s).count
                  item.destroy
                end
              end
            end

            JSON.parse(item_params.to_s).each_with_index do |item, index|
              unless @request.items[index].nil?
                @request.items[index].update!(item)
              else
                @request.items.create!(item)
              end              
            end             

          end

          unless question_params.empty?

            unless JSON.parse(question_params.to_s).count > @request.questions.count
              @request.questions.each_with_index do |question, index|
                if index >= JSON.parse(question_params.to_s).count
                  question.destroy
                end
              end
            end

            JSON.parse(question_params.to_s).each_with_index do |question, index|
              unless @request.questions[index].nil?
                @request.questions[index].update!(question)
              else
                @request.questions.create!(question)
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

            if @request.folder_id == 1
              if request_params.has_key? 'clarificatoin'              
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
              else
                @request.suppliers.each do |supplier|
                  TenderBooksNotifierMailer.invite_supplier(supplier, @request).deliver_later
                  @request.messages.create!(
                    from: 'buyer',
                    read: false,
                    user_id: current_user.id,
                    supplier_id: supplier.id,
                    content: 'Please apply...'
                    )
                end
                TenderBooksNotifierMailer.invite_notifier(current_user, @request).deliver_later                  
              end
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

  def invite_supplier
    if participant_params.nil?

      flash[:error] = 'You need to add at least one participiant.'
      redirect_back fallback_location: new_request_url

    else

      respond_to do |format|

        participant_params.each do |participant|
          supplier = Supplier.find_or_create_by(email: participant)
          if supplier.bids.where(request_id: @request.id).where(status: 'reject').exists?
            supplier.bids.where(request_id: @request.id).where(status: 'reject').first.destroy
          else       
            @request.suppliers << supplier
          end
          if User.where(email: supplier.email).exists?
            supplier.update( user_id: User.where(email: supplier.email).first.id )
          end
          TenderBooksNotifierMailer.invite_supplier(supplier, @request).deliver_later
          @request.messages.create!(
            from: 'buyer',
            read: false,
            user_id: current_user.id,
            supplier_id: supplier.id,
            content: 'Please apply...'
            )
        end

        format.html { redirect_to @request, notice: "Invitation was successfully sent to suppliers you just added." }
        format.json { render :show, status: :ok, location: @request }

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
    @bids       = @request.bids.where.not(status: 'reject').group_by(&:supplier)    
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

  def delete_document
    begin      
      key = url_decode params[:key]
      key = key.split('amazonaws.com/').last.gsub '+', ' '   
      if S3_BUCKET.object(key).delete
        render json: { status: 'ok' }
      else
        render json: { status: 'error', message: 'Error to delete document...' }
      end
    rescue Exception => e
      render json: { status: 'error', message: e.join(',') }
    end
  end

  def export_excel
    @total_bids = @request.bids
    @bids       = @request.bids.where.not(status: 'reject').group_by(&:supplier)
    @suppliers  = @request.suppliers
    filename    = "Bid_comparison_table_##{@request.id}_#{@request.name.tr(" ", "_")}.xlsx"

    respond_to do |format|
      format.xlsx{
        response.headers['Content-Disposition'] = "attachment; filename=#{filename}"
      } 
    end
  end

  def preview_request

    session[:request_params]   = request_params
    session[:item_params]      = item_params
    session[:question_params]  = question_params
    session[:category_params]  = category_params
    session[:participants]     = participant_params

    @request = Request.new(request_params)

    unless item_params.nil?
      unless item_params.empty?
        JSON.parse(item_params.to_s).each do |item|
          @request.items.build(item)
        end
      end
    end

    unless question_params.nil?
      unless item_params.empty?
        JSON.parse(question_params.to_s).each do |question|
          @request.questions.build(question)
        end
      end
    end

  end

  def preview_invite
    supplier = Supplier.create!(email: params[:email])
    request  = Request.create!(name: params[:name], end_time: params[:end_time], description: params[:description] )
    if TenderBooksNotifierMailer.invite_supplier(supplier, request).deliver_later
      render json: { status: 'ok' }
    else
      render json: { status: 'error' }
    end
    supplier.destroy
    request.destroy
  end

  def pdf
    @request.to_pdf
    send_file "#{Rails.root}/public/download/#{@request.created_at.strftime("%Y-%m-%d")}-#{@request.name}-##{@request.id}/#{@request.name}.pdf"
  end

  def download
    @request.to_pdf
    @request.bids.each do |bid|
      unless bid.status == 'reject'
        bid.to_pdf
      end
    end
    inputs  = "#{Rails.root}/public/download/#{@request.created_at.strftime("%Y-%m-%d")}-#{@request.name}-##{@request.id}"
    outputs = "#{Rails.root}/public/download/#{@request.created_at.strftime("%Y-%m-%d")}-#{@request.name}-##{@request.id}.zip"
    zip   = ZipFileGenerator.new(inputs, outputs)
    if zip.write
      send_file outputs
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

    def url_decode(s)
     s.gsub(/((?:%[0-9a-fA-F]{2})+)/n) do
       [$1.delete('%')].pack('H*')
     end
   end

 end
