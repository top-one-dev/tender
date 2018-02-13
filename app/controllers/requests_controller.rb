class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_company
  before_action :set_s3_direct_post, only: [:new, :create]

  # GET /requests
  # GET /requests.json
  def index
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
  end

  # POST /requests
  # POST /requests.json
  def create
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
        
        format.html { redirect_to requests_path, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: requests_path }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
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
      @s3_direct_post = S3_BUCKET.presigned_post(key: "requests/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end

end
