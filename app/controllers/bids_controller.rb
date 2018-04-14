class BidsController < ApplicationController
  # before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :pdf]
  before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]
  before_action :set_qanswer_s3_direct_post, only: [:new, :create, :edit, :update]
  
  # GET /bids
  # GET /bids.json
  def index
    @bids = current_user.supplier.bids.where(:status => 'sent')
    @active_bids = []
    @ended_bids  = []
    @bids.each do |bid|
      if bid.request.end_time > Time.now 
        @active_bids << bid
      else
        @ended_bids  << bid
      end 
    end
    unless current_user.supplier.nil?
      @supplier_token = crypt.encrypt_and_sign current_user.supplier.id
    end 
    # @bids = current_user.supplier.bids
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid          = Bid.new
    @request      = Request.find params[:id]
    @questions    = @request.questions
    if @request.items.exists?
      @items      = @request.items
    end
    @supplier     = Supplier.find crypt.decrypt_and_verify(params[:token])
    @status       = 'sent'
  end

  # GET /bids/1/edit
  def edit
    @request   = @bid.request
    @supplier  = @bid.supplier
    @questions    = @request.questions
    if @request.items.exists?
      @items      = @request.items
    end
    @status       = 'sent'
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)    

    respond_to do |format|
      if @bid.save
        
        @supplier = Supplier.find(bid_params[:supplier_id])
        @supplier.update!(supplier_params)

        if @bid.status == 'reject'
          
          format.html { redirect_to view_request_url(@bid.request.id, crypt.encrypt_and_sign(bid_params[:supplier_id])), notice: 'You just rejected making a bid on the request. Thanks for your informing.' }
          TenderBooksNotifierMailer.reject_invite(current_user, @supplier, @bid.request).deliver_later
        
        else          

          @items  = @bid.request.items

          @items.each_with_index do |item, index|
            @bid.ianswers.create!(item_id: item.id, unit_price: ianswer_params[index])
          end

          @questions = @bid.request.questions

          index1 = 0

          @questions.each_with_index do |question, index|
            if question.enable_attatch
              @bid.qanswers.create!(question_id: question.id, answer: qanswer_params[:answer][index], attach: qanswer_params[:attach][index1] )
              index1 += 1
            else
              @bid.qanswers.create!(question_id: question.id, answer: qanswer_params[:answer][index] )
            end       
          end

          TenderBooksNotifierMailer.bid_supplier(@bid.request.user, @bid.supplier, @bid).deliver_later
          TenderBooksNotifierMailer.bid_buyer(@bid.request.user, @bid.supplier, @bid.request).deliver_later

          if @bid.supplier.user.nil?
            format.html { redirect_to view_request_url(@bid.request.id, crypt.encrypt_and_sign(@supplier.id)), notice: "<small>We have received your bid. Thanks fo rtaking the time to submit it.<br> You can review your bid by clicking the <b>My Bids</b> button on the right. To change your bid, please submit a new one with <b>Edit bid</b>.<br> Your most recent bid is considered valid. Bids can be changed until the end time of the request.</small>".html_safe }
          else
            if user_signed_in?
              format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
              format.json { render :show, status: :created, location: @bid }  
            else              
              format.html { redirect_to new_user_session_path, notice: "Successfully submitted. You need to signin to continue because you have already account on TenderBooks." }
            end
          end         

        end
        
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        
        @supplier = @bid.supplier
        @items    = @bid.request.items

        @items.each_with_index do |item, index|
          @bid.ianswers.where(item_id: item.id).first.update!(unit_price: ianswer_params[index])
        end

        @questions = @bid.request.questions

        index1 = 0

        @questions.each_with_index do |question, index|
          if question.enable_attatch
            @bid.qanswers.where(question_id: question.id).first.update!( answer: qanswer_params[:answer][index], attach: qanswer_params[:attach][index1] )
            index1 += 1
          else
            @bid.qanswers.where(question_id: question.id).first.update!( answer: qanswer_params[:answer][index] )
          end       
        end
        format.html { redirect_to view_request_url(@bid.request.id, crypt.encrypt_and_sign(@supplier.id)), notice: "<small>We have received your updated bid. Thanks fo rtaking the time to submit it.<br> You can review your bid by clicking the <b>My Bids</b> button on the right. To change your bid, please submit a new one with <b>Edit bid</b>.<br> Your most recent bid is considered valid. Bids can be changed until the end time of the request.</small>".html_safe }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    request  = @bid.request
    supplier = @bid.supplier
    request.bids.create(supplier_id: supplier.id, status: 'reject')
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to view_request_url(request.id, crypt.encrypt_and_sign(supplier.id)), notice: "You just declined your bid on the request<br> Thanks for your informing...".html_safe }
      format.json { head :no_content }
    end
  end

  def pdf
    @bid.to_pdf
    send_file "#{Rails.root}/public/download/#{@bid.request.created_at.strftime("%Y-%m-%d")}-#{@bid.request.name}-##{@bid.request.id}/Bids/#{@bid.supplier.company}_#{@bid.supplier.id}/#{@bid.id}/#{@bid.supplier.company}_#{@bid.request.id}_#{@bid.id}.pdf"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:request_id, :supplier_id, :content, :status, :bid_budget, :bid_currency)
    end

    def supplier_params
      params.require(:supplier).permit(:email, :company, :mobile, :phone, :name)
    end

    def ianswer_params
      params[:ianswers]
    end

    def qanswer_params
      params[:qanswers]
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "bids/#{Time.now.strftime("%Y%m%d%H%M%S%L")}/${filename}", success_action_status: '201', acl: 'public-read')
    end

    def set_qanswer_s3_direct_post
      @qanswer_s3_direct_post = S3_BUCKET.presigned_post(key: "qanswers/#{Time.now.strftime("%Y%m%d%H%M%S%L")}/${filename}", success_action_status: '201', acl: 'public-read')
    end

end
