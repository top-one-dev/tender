class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:edit, :update]
  before_action :authenticate_user!

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit    
  end

  # POST /companies
  # POST /companies.json
  def create
    
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        session[:current_company_id] = @company.id
        @company.users << current_user
        format.html { redirect_to edit_user_registration_path, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to edit_user_registration_path, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invite_colleague
    unless colleague_params[:company].nil?
      @company = Company.find colleague_params[:company]
      if User.where(email: colleague_params[:email]).exists?
        @user = User.where(email: colleague_params[:email]).first
        @user.update(company: @company.id)
        if @user.company and !@user.confirmed_at          
          is_new_user = true 
        else          
          is_new_user = false
        end
      else
        @user = User.new({  email:                  colleague_params[:email], 
                            name:                   colleague_params[:name], 
                            phone:                  colleague_params[:phone],
                            mobile:                 colleague_params[:mobile],
                            company:                colleague_params[:company],
                            password:               "#{colleague_params[:email]}password",
                            password_confirmation:  "#{colleague_params[:email]}password"  })

        @user.save
        is_new_user = true
      end

      respond_to do |format|
        if TenderBooksNotifierMailer.company_invite_colleague(@user, @company, is_new_user).deliver_later
          format.html { redirect_to @company, notice: 'An invite was successfully sent.' }
          format.json { render json: {  status: 'success', message: 'An invite was successfully sent.' } }
        else
          format.html { redirect_to @company, error: 'There is some error to send an invite.' }
          format.json { render json: {  status: 'error', message: @user.errors.full_messages.join(',') } }
        end
      end 
    end
  end

  def accept_colleage_invite
    @company  = Company.find params[:company]
    @user     = User.find params[:user]

    respond_to do |format|
      if @company.users << @user
        @user.update(company: nil)
        format.html { redirect_to @company, notice: 'Thanks for accepting invitation.' }
        format.json { render json: {  status: 'success', message: 'Thanks for accepting invitation.' } }
      else
        format.html { redirect_to root_url, error: 'There is some error to accept an invite.' }
        format.json { render json: {  status: 'error', message: 'There is some error to accept an invite.' } }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
      session[:current_company_id] = @company.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :logo, :country, :city, :address, :zip, :email, :phone, :homepage, { business_type: [] }, :employees, :turnover, :established, :introduction, :language, :user)
    end

    def colleague_params
      params.require(:colleague).permit(:name, :email, :phone, :mobile, :company)      
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "logos/#{@company.id}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
