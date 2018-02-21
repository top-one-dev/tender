class IanswersController < ApplicationController
  before_action :set_ianswer, only: [:show, :edit, :update, :destroy]

  # GET /ianswers
  # GET /ianswers.json
  def index
    @ianswers = Ianswer.all
  end

  # GET /ianswers/1
  # GET /ianswers/1.json
  def show
  end

  # GET /ianswers/new
  def new
    @ianswer = Ianswer.new
  end

  # GET /ianswers/1/edit
  def edit
  end

  # POST /ianswers
  # POST /ianswers.json
  def create
    @ianswer = Ianswer.new(ianswer_params)

    respond_to do |format|
      if @ianswer.save
        format.html { redirect_to @ianswer, notice: 'Ianswer was successfully created.' }
        format.json { render :show, status: :created, location: @ianswer }
      else
        format.html { render :new }
        format.json { render json: @ianswer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ianswers/1
  # PATCH/PUT /ianswers/1.json
  def update
    respond_to do |format|
      if @ianswer.update(ianswer_params)
        format.html { redirect_to @ianswer, notice: 'Ianswer was successfully updated.' }
        format.json { render :show, status: :ok, location: @ianswer }
      else
        format.html { render :edit }
        format.json { render json: @ianswer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ianswers/1
  # DELETE /ianswers/1.json
  def destroy
    @ianswer.destroy
    respond_to do |format|
      format.html { redirect_to ianswers_url, notice: 'Ianswer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ianswer
      @ianswer = Ianswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ianswer_params
      params.require(:ianswer).permit(:unit_price, :quantity, :item_id, :supplier_id)
    end
end
