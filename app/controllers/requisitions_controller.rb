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
      @requisitions           = current_company.requisitions
      @new_requisitions       = current_company.requisitions.where(status: 'new')
      @open_requisitions      = current_company.requisitions.where(status: 'open')
      @closed_requisitions    = current_company.requisitions.where(status: 'closed')
      @returned_requisitions  = current_company.requisitions.where(status: 'returned')
      @tendering_requisitions = current_company.requisitions.where(status: 'tendering')

      company_token           = crypt.encrypt_and_sign current_company.id
      @web_form               = new_requisition_url(token: company_token)
    end
  end

  # GET /requisitions/1
  # GET /requisitions/1.json
  def show
    if current_company.nil?      
      
      if params[:token].nil?
        flash[:error] = "Invalid token... Please look at url again."
        redirect_to root_path 
      else
        begin
          @requisitioner =  @requisition.contact_email if @requisition.contact_email == crypt.decrypt_and_verify(params[:token])
          if @requisitioner.nil?
            @requisition.stockholders.each do |colleague|
              @colleague = colleague if colleague.email == crypt.decrypt_and_verify(params[:token])
            end
          end
        rescue Exception => e
          flash[:error] = "Invalid token... Please look at url again."
          redirect_to root_path
        end       
      end

    else

      if current_company.requisitions.include? @requisition
        @is_company = true
      else
        flash[:error] = "Invalid token... Please look at url again."
        redirect_to root_path
      end

    end
  end

  # GET /requisitions/new
  def new
    begin      
      @company       = Company.find crypt.decrypt_and_verify(params[:token])
      @requisition   = @company.requisitions.build
      @status        = 'new'
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

        unless colleague_params.empty?
          JSON.parse(colleague_params.to_s).each do |stockholder|
            @requisition.stockholders.create!(stockholder)
          end
        end

        TenderBooksNotifierMailer.create_requisition_company(@requisition, @requisition.company).deliver_later
        TenderBooksNotifierMailer.create_requisition_requisitioner(@requisition).deliver_later
        @requisition.stockholders.each do |colleague|
          TenderBooksNotifierMailer.create_requisition_colleague(@requisition, colleague).deliver_later
        end         

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

    def colleague_params
      params[:colleague]
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "requisitions/#{Time.now.strftime("%Y%m%d%H%M%S%L")}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
