class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    if params[:id].nil?
      if current_user.requests.exists?
        @request = current_user.requests.first
      elsif !current_user.supplier.nil?
        @request = current_user.supplier.requests.first
      end
    else
      @request = Request.find params[:id]
    end

    unless @request.nil?
      @messages   = @request.messages
      @requests   = current_user.requests
      unless current_user.supplier.nil?
        @supplier_requests = current_user.supplier.requests
        @requests = @requests.to_a.concat @supplier_requests.to_a
      end  
    end

    if @requests.nil?
      @requests.uniq!
    else
      @requests = []
    end 
    
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully sent.' }
        format.json { render json: {  status: 'success', message: 'Message was successfully sent.' } }
      else
        format.html { render :new }
        format.json { render json: {  status: 'error', message: @message.errors.full_messages.join(',') } }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render json: {  status: 'success', message: 'Message was successfully updated.' } }
      else
        format.html { render :edit }
        format.json { render json: {  status: 'error', message: @message.errors.full_messages.join(',') } }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :attach, :from, :read, :user_id, :supplier_id, :request_id, :requisition_id )
    end
end
