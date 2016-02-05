class InspectionSchedulesController < ApplicationController
  before_action :set_inspection_schedule, only: [
    :show, :edit, :update, :destroy, :do_inspection, :done_inspection, :close_inspection
  ]

  # GET /inspection_schedules
  # GET /inspection_schedules.json
  def index
    @search = InspectionSchedule.search(params[:q])
    @inspection_schedules = @search.result.order(:targetyearmonth, :id).page(params[:page])
    @my_schedules = InspectionSchedule.my_schedules(current_user.company)
  end

  # GET /inspection_schedules/1
  # GET /inspection_schedules/1.json
  def show
    @inspection_results = @inspection_schedule.inspection_result.all
  end

  # GET /inspection_schedules/1/do_inspection
  def do_inspection
    @inspection_results = @inspection_schedule.inspection_result.all
    @inspection_result = @inspection_schedule.inspection_result.build
    @inspection_result.user_id = @inspection_schedule.user_id
    @check = @inspection_result.build_check
    @measurement = @inspection_result.build_measurement
    @note = @inspection_result.build_note
  end

  # GET /inspection_schedules/1/done_inspection
  def done_inspection
    @inspection_results = @inspection_schedule.inspection_result.all
  end

  # GET /inspection_schedules/new
  def new
    @inspection_schedule = InspectionSchedule.new
  end

  # GET /inspection_schedules/1/edit
  def edit
  end

  # POST /inspection_schedules
  # POST /inspection_schedules.json
  def create
    @inspection_schedule = InspectionSchedule.new(inspection_schedule_params)

    respond_to do |format|
      if @inspection_schedule.save
        format.html { redirect_to @inspection_schedule, notice: "InspectionSchedule was successfully created." }
        format.json { render :show, status: :created, location: @inspection_schedule }
      else
        format.html { render :new }
        format.json { render json: @inspection_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspection_schedules/1
  # PATCH/PUT /inspection_schedules/1.json
  def update
    respond_to do |format|
      if @inspection_schedule.update(inspection_schedule_params)
        format.html { redirect_to @inspection_schedule, notice: "InspectionSchedule was successfully updated." }
        format.json { render :show, status: :ok, location: @inspection_schedule }
      else
        format.html { render :edit }
        format.json { render json: @inspection_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspection_schedules/1
  # DELETE /inspection_schedules/1.json
  def destroy
    @inspection_schedule.destroy
    respond_to do |format|
      format.html { redirect_to inspection_schedules_url, notice: "InspectionSchedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_inspection_schedules
    InspectionSchedule.bulk_create(InspectionScheduleParam.new(params), current_date)
    redirect_to noinspection_list_url
  end

  # 点検予定の生成(YES拠点の指定年月)
  def make_branch_yyyymm
    InspectionSchedule.make_branch_yyyym(current_user.company_id, params[:when][:year], params[:when][:month], current_date)
    redirect_to root_path, notice: t('controllers.inspection_schedules.make_branch_yyyymm')
  end

  # 点検完了の登録
  def close_inspection
    @approval = @inspection_schedule.build_approval
    @approval.signature = params[:sign]

    @inspection_schedule.close_inspection

    respond_to do |format|
      if @inspection_schedule.save && @approval.save
        format.html { redirect_to inspection_schedule_url, notice: "InspectionSchedule was successfully closed." }
        format.json { head :no_content }
      else
        format.html { render :done_inspection }
        format.json { render json: @inspection_schedule.errors, status: :unprocessable_close }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inspection_schedule
    @inspection_schedule = InspectionSchedule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inspection_schedule_params
    params.require(:inspection_schedule).permit(
      :targetyearmonth, :equipment_id, :status_id, :user_id, :result_id, :processingdate
    )
  end
end
