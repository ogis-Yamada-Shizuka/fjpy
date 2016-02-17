class InspectionResultsController < ApplicationController
  before_action :set_inspection_result, only: [:show, :edit, :update, :destroy]

  # GET /inspection_results
  # GET /inspection_results.json
  def index
    # TODO: ここやることないので except していいかも。
    @inspection_result = InspectionResult.first
  end

  # GET /inspection_results/1
  # GET /inspection_results/1.json
  def show
    @marker = Gmaps4rails.build_markers(@inspection_result) do |inspection_result, marker|
      marker.lat inspection_result.latitude
      marker.lng inspection_result.longitude
      marker.infowindow inspection_result.updated_at.to_s
      marker.json(title: inspection_result.user_id.to_s)
    end
  end

  # GET /inspection_results/new
  def new
    @inspection_result = InspectionResult.new
  end

  # GET /inspection_results/1/edit
  def edit
  end

  # POST /inspection_results
  # POST /inspection_results.json
  def create
    @inspection_result = InspectionResult.new(inspection_result_params)


    # TODO: ここで落ちる kilogy からのバグがある。(inspection_schedule_id を hidden で入れる？)
    inspection = InspectionSchedule.where(id: params[:inspection_result][:inspection_schedule_id]).first

    inspection.start_inspection # 点検開始

    respond_to do |format|
      if @inspection_result.save && inspection.save
        format.html { redirect_to @inspection_result, notice: "InspectionResult was successfully created." }
        format.json { render :show, status: :created, location: @inspection_result }
      else
        format.html { render :new }
        format.json { render json: @inspection_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspection_results/1
  # PATCH/PUT /inspection_results/1.json
  def update
    respond_to do |format|
      if @inspection_result.update(inspection_result_params)
        format.html { redirect_to @inspection_result, notice: "InspectionResult was successfully updated." }
        format.json { render :show, status: :ok, location: @inspection_result }
      else
        format.html { render :edit }
        format.json { render json: @inspection_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspection_results/1
  # DELETE /inspection_results/1.json
  def destroy
    @inspection_result.destroy
    respond_to do |format|
      format.html { redirect_to inspection_results_url, notice: "InspectionResult was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inspection_result
    @inspection_result = InspectionResult.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inspection_result_params
    params.require(:inspection_result).permit(
      :inspection_schedule_id, :user_id, :latitude, :longitude,
      measurement_attributes: [:id, :inspection_result_id, :metercount, :testervalue, :point],
      check_attributes: [:id, :inspection_result_id, :weather_id, :exterior_id, :tone_id, :stain_id],
      note_attributes: [:id, :inspection_result_id, :memo, :picture])
  end
end
