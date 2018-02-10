class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_company

  # GET /requests
  # GET /requests.json
  def index
    unless current_company.nil?
      @requests = current_company.requests.where(:user_id => current_user.id)
    else
      @requests = nil
    end 
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new type
    @request = Request.new
    @type    = type
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
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
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
      params.require(:request).permit(:name, :end_time, :description, :attach, :user_id, :company_id, :folder_id, :type)
    end

    def set_company
      if Company.where(:user => current_user.id).exists?
        session[:current_company_id] = Company.where(:user => current_user.id).first.id if session[:current_company_id].nil?
      else
        session[:current_company_id] = 0
      end 
    end

end
