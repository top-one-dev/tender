class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :destroy]
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

      @requests = current_company.requests.where(:user_id => current_user.id)
      @requests.each do |request|
        if Time.now > request.end_time
          @ended_requests << request
        else
          @active_requests << request
        end
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
  end

  # POST /requests
  # POST /requests.json
  def create

    if participant_params.nil?

      flash[:error] = 'You need to add at least one participiant.'
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
                supplier.update( user_id: current_user.id )
              end
              TenderBooksNotifierMailer.invite_supplier(supplier, @request).deliver
              TenderBooksNotifierMailer.invite_notifier(current_user, supplier, @request).deliver
              @request.messages.create!(
                                        from: 'buyer',
                                        read: false,
                                        user_id: current_user.id, 
                                        supplier_id: supplier.id,
                                        content: 'Please apply...'
                                      )
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
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
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
                                      :request_type
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
      if Company.where(:user => current_user.id).exists?
        session[:current_company_id] = Company.where(:user => current_user.id).first.id if session[:current_company_id].nil?
      else
        session[:current_company_id] = 0
      end 
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "requests/#{current_user.id}/#{Time.now.strftime("%Y%m%d%H%M")}/${filename}", success_action_status: '201', acl: 'public-read')
    end

end
