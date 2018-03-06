class StockholdersController < ApplicationController
  before_action :set_stockholder, only: [:show, :edit, :update, :destroy]

  # GET /stockholders
  # GET /stockholders.json
  def index
    @stockholders = Stockholder.all
  end

  # GET /stockholders/1
  # GET /stockholders/1.json
  def show
  end

  # GET /stockholders/new
  def new
    @stockholder = Stockholder.new
  end

  # GET /stockholders/1/edit
  def edit
  end

  # POST /stockholders
  # POST /stockholders.json
  def create
    @stockholder = Stockholder.new(stockholder_params)

    respond_to do |format|
      if @stockholder.save
        # TenderBooksNotifierMailer.create_requisition_company(@requisition, @requisition.company).deliver_later
        # TenderBooksNotifierMailer.create_requisition_requisitioner(@requisition).deliver_later
        TenderBooksNotifierMailer.create_requisition_colleague(@stockholder.requisition, @stockholder).deliver_later

        format.html { redirect_to @stockholder, notice: 'Stockholder was successfully created.' }
        format.json { render json: {  status: 'success', url: stockholder_url(@stockholder), message: 'Stockholder was successfully created.' } }
      else
        format.html { render :new }
        format.json { render json: {  status: 'error', message: @stockholder.errors.full_messages.join(',') } }
      end
    end
  end

  # PATCH/PUT /stockholders/1
  # PATCH/PUT /stockholders/1.json
  def update
    respond_to do |format|
      if @stockholder.update(stockholder_params)
        format.html { redirect_to @stockholder, notice: 'Stockholder was successfully updated.' }
        format.json { render json: {  status: 'success', message: 'Stockholder was successfully updated.' } }
      else
        format.html { render :edit }
        format.json { render json: {  status: 'error', message: @stockholder.errors.full_messages.join(',') } }
      end
    end
  end

  # DELETE /stockholders/1
  # DELETE /stockholders/1.json
  def destroy
    colleague = {}
    colleague[:name]  = @stockholder.name
    colleague[:email] = @stockholder.email
    requisition       = @stockholder.requisition
    @stockholder.destroy
    respond_to do |format|
      TenderBooksNotifierMailer.remove_colleague(requisition, colleague).deliver_later
      format.html { redirect_to stockholders_url, notice: 'Stockholder was successfully destroyed.' }
      format.json { render json: {  status: 'success', message: 'Stockholder was successfully destroyed.' } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stockholder
      @stockholder = Stockholder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stockholder_params
      params.require(:stockholder).permit(:name, :email, :job, :phone, :requisition_id)
    end
end
