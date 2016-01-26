class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy, :do_inspection, :done_inspection, :closeInspection]

  # GET /inspections
  # GET /inspections.json
  def index
    #@inspections = Inspection.all
    @search = Inspection.search(params[:q])
    @inspections = @search.result.order(:targetyearmonth, :id).page(params[:page])

  end

  # GET /inspections/1
  # GET /inspections/1.json
  def show
    @inspection_results = @inspection.inspection_result.all
  end

  # GET /inspections/1/do_inspection
  def do_inspection
    @inspection_results = @inspection.inspection_result.all
    @inspection_result = @inspection.inspection_result.build
    @inspection_result.user_id = @inspection.user_id
    @check =  @inspection_result.build_check
    @measurement = @inspection_result.build_measurement
    @note = @inspection_result.build_note
  end

  # GET /inspections/1/done_inspection
  def done_inspection
    @inspection_results = @inspection.inspection_result.all
  end

  # GET /inspections/new
  def new
    @inspection = Inspection.new
  end

  # GET /inspections/1/edit
  def edit
  end

  # POST /inspections
  # POST /inspections.json
  def create
    @inspection = Inspection.new(inspection_params)

    respond_to do |format|
      if @inspection.save
        format.html { redirect_to @inspection, notice: 'Inspection was successfully created.' }
        format.json { render :show, status: :created, location: @inspection }
      else
        format.html { render :new }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspections/1
  # PATCH/PUT /inspections/1.json
  def update
    respond_to do |format|
      if @inspection.update(inspection_params)
        format.html { redirect_to @inspection, notice: 'Inspection was successfully updated.' }
        format.json { render :show, status: :ok, location: @inspection }
      else
        format.html { render :edit }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspections/1
  # DELETE /inspections/1.json
  def destroy
    @inspection.destroy
    respond_to do |format|
      format.html { redirect_to inspections_url, notice: 'Inspection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def createInspections
    Inspection.bulk_create(InspectionParam.new(params), currentDate)
    redirect_to noinspection_list_url
  end

  # 点検完了の登録
  def  closeInspection
    @approval = @inspection.build_approval
    @approval.signature = params[:sign]

    @inspection.close_inspection

    respond_to do |format|
      if @inspection.save && @approval.save
        format.html { redirect_to inspection_url, notice: 'Inspection was successfully closed.' }
        format.json { head :no_content }
      else
        format.html { render :done_inspection }
        format.json { render json: @inspection.errors, status: :unprocessable_close }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_params
      params.require(:inspection).permit(:targetyearmonth, :equipment_id, :status_id, :user_id, :result_id, :processingdate)
    end
end
