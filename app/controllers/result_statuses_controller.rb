class ResultStatusController < ApplicationController
  before_action :set_result_status, only: [:show, :edit, :update, :destroy]

  # GET /result_statuses
  # GET /result_statuses.json
  def index
    @result_statuses = ResultStatus.all
  end

  # GET /result_statuses/1
  # GET /result_statuses/1.json
  def show
  end

  # GET /result_statuses/new
  def new
    @result_status = ResultStatus.new
  end

  # GET /result_statuses/1/edit
  def edit
  end

  # POST /result_statuses
  # POST /result_statuses.json
  def create
    @result_status = ResultStatus.new(result_status_params)

    respond_to do |format|
      if @result_status.save
        format.html { redirect_to @result_status, notice: "ResultStatus was successfully created." }
        format.json { render :show, status: :created, location: @result_status }
      else
        format.html { render :new }
        format.json { render json: @result_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /result_statuses/1
  # PATCH/PUT /result_statuses/1.json
  def update
    respond_to do |format|
      if @result_status.update(result_params)
        format.html { redirect_to @result_status, notice: "ResultStatus was successfully updated." }
        format.json { render :show, status: :ok, location: @result_status }
      else
        format.html { render :edit }
        format.json { render json: @result_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /result_statuses/1
  # DELETE /result_statuses/1.json
  def destroy
    @result_status.destroy
    respond_to do |format|
      format.html { redirect_to result_statuses_url, notice: "ResultSTATUS was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_result_status
    @result_status = ResultStatus.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def result_params
    params.require(:result_status).permit(:name)
  end
end
