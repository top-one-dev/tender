class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
  	if current_company.nil?
      flash[:notice] = 'You need to set company first.'
      redirect_to new_company_path
    else
    	@suppliers = current_company.suppliers
    end
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Supplier was successfully created.' }
        format.json { render :show, status: :created, location: @supplier }
      else
        format.html { render :new }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: 'Supplier was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Supplier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def view_request
    unless Request.where(id: params[:id]).exists?
      flash[:error] = 'There is no relevant request. Please check link you received.'
      redirect_to root_path
      return
    end

    @request        = Request.find params[:id]
    
    begin      
      @supplier       = Supplier.find crypt.decrypt_and_verify(params[:token])
      @supplier_token = params[:token]
      @reject_params  = { 
                          :bid => {
                            :request_id   => @request.id,
                            :supplier_id  => @supplier.id,
                            :status       => 'reject'
                          }
                        }
      if @supplier.nil? and @request.permission == 'public' and user_signed_in?
        @supplier       = current_user.supplier.create!(  name:     current_user.name, 
                                                          company:  current_user.companies.first.name, 
                                                          phone:    current_user.phone, 
                                                          email:    current_user.email,
                                                          mobile:   current_user.mobile )
        @supplier_token = crypt.encrypt_and_sign @supplier.id
      end
    rescue => detail
      # flash[:error] = 'You typed invalid token. Please check link you received.'
      # redirect_to root_path   
    end   
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:name, :address, :email, :categories, :user_id)
    end
end
