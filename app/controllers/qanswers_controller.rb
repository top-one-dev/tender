class QanswersController < ApplicationController
  before_action :set_qanswer, only: [:show, :edit, :update, :destroy]

  # GET /qanswers
  # GET /qanswers.json
  def index
    @qanswers = Qanswer.all
  end

  # GET /qanswers/1
  # GET /qanswers/1.json
  def show
  end

  # GET /qanswers/new
  def new
    @qanswer = Qanswer.new
  end

  # GET /qanswers/1/edit
  def edit
  end

  # POST /qanswers
  # POST /qanswers.json
  def create
    @qanswer = Qanswer.new(qanswer_params)

    respond_to do |format|
      if @qanswer.save
        format.html { redirect_to @qanswer, notice: 'Qanswer was successfully created.' }
        format.json { render :show, status: :created, location: @qanswer }
      else
        format.html { render :new }
        format.json { render json: @qanswer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qanswers/1
  # PATCH/PUT /qanswers/1.json
  def update
    respond_to do |format|
      if @qanswer.update(qanswer_params)
        format.html { redirect_to @qanswer, notice: 'Qanswer was successfully updated.' }
        format.json { render json: {  status: 'success', message: 'Qanswer was successfully updated.' } }
      else
        format.html { render :edit }
        format.json { render json: {  status: 'success', message: @qanswer.error } }
      end
    end
  end

  # DELETE /qanswers/1
  # DELETE /qanswers/1.json
  def destroy
    @qanswer.destroy
    respond_to do |format|
      format.html { redirect_to qanswers_url, notice: 'Qanswer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qanswer
      @qanswer = Qanswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qanswer_params
      params.require(:qanswer).permit(:answer, :attach, :question_id, :supplier_id, :comments, :like )
    end
end
