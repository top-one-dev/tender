class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]

  # GET /requisitions
  # GET /requisitions.json
  def index
    if current_company.nil?
      flash[:notice] = 'You need to set company before creating requisition.'
      redirect_to new_company_path
    else 
      @requisitions           = Requisition.all
      @new_requisitions       = Requisition.where(status: 'new')
      @open_requisitions      = Requisition.where(status: 'open')
      @closed_requisitions    = Requisition.where(status: 'closed')
      @returned_requisitions  = Requisition.where(status: 'returned')
      @tendering_requisitions = Requisition.where(status: 'tendering')

      company_token           = crypt.encrypt_and_sign current_company.id
      @web_form               = new_requisition_url(token: company_token)
    end
  end

  # GET /requisitions/1
  # GET /requisitions/1.json
  def show
  end

  # GET /requisitions/new
  def new
    begin      
      @company       = Company.find crypt.decrypt_and_verify(params[:token])
      @requisition   = @company.requisitions.build
    rescue => detail
      flash[:error] = 'You typed invalid token. Please check link you received.'
      redirect_to root_path   
    end    
  end

  # GET /requisitions/1/edit
  def edit
  end

  # POST /requisitions
  # POST /requisitions.json
  def create
    @requisition = Requisition.new(requisition_params)

    respond_to do |format|
      if @requisition.save
        format.html { redirect_to @requisition, notice: 'Requisition was successfully created.' }
        format.json { render :show, status: :created, location: @requisition }
      else
        format.html { render :new }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requisitions/1
  # PATCH/PUT /requisitions/1.json
  def update
    respond_to do |format|
      if @requisition.update(requisition_params)
        format.html { redirect_to @requisition, notice: 'Requisition was successfully updated.' }
        format.json { render :show, status: :ok, location: @requisition }
      else
        format.html { render :edit }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisitions/1
  # DELETE /requisitions/1.json
  def destroy
    @requisition.destroy
    respond_to do |format|
      format.html { redirect_to requisitions_url, notice: 'Requisition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requisition
      @requisition = Requisition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requisition_params
      params.require(:requisition).permit(:name, :description, :delivery_date, :quantity, :budget, :budget_currency, :project, :cost_center, :delivery_address, :contact_name, :contact_email, :contact_phone, :contact_department, :contact_manager, :additional_document, :company_id, :user_id, :status)
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "requisitions/#{Time.now.strftime("%Y%m%d%H%M%S%L")}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
