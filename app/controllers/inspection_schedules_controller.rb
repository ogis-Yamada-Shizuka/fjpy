class InspectionSchedulesController < ApplicationController
  before_action :set_inspection_schedule, only: [
    :show, :edit, :update, :destroy, :do_inspection, :done_inspection, :approve_inspection, :close_inspection, :complete_inspection
  ]

  before_action :set_query_to_params, only: %i(index requested_soon date_answered target done)
  before_action :set_inspection_schedules, only: :index

  # GET /inspection_schedules
  # GET /inspection_schedules.json
  def index
  end

  def requested_soon
    params[:q][:schedule_status_id_eq] = ScheduleStatus.of_requested
    params[:q][:target_yearmonth_date_lteq] = Date.parse(current_date) >> Constants::LATEST_MONTH
    set_inspection_schedules
    render :index
  end

  def date_answered
    params[:q][:schedule_status_id_eq] = ScheduleStatus.of_date_answered
    set_inspection_schedules
    render :index
  end

  def target
    params[:q][:schedule_status_id_in] = ScheduleStatus.inspection_target_ids
    set_inspection_schedules
    render :index
  end

  def done
    params[:q][:schedule_status_id_in] = ScheduleStatus.done_ids
    set_inspection_schedules
    render :index
  end

  # GET /inspection_schedules/1
  # GET /inspection_schedules/1.json
  def show
    @same_place_inspection_schedules = InspectionSchedule.with_place(@inspection_schedule.place).order_by_target_yearmonth
  end

  # GET /inspection_schedules/1/do_inspection
  def do_inspection
    if @inspection_schedule.can_inspection? # 点検開始して良い状態か？
      if @inspection_schedule.result.nil? # 初回か？ → 初回なら点検実績を新規作成
        @inspection_result = InspectionResult.new(inspection_schedule: @inspection_schedule)
        @inspection_result.user = current_user
        @check = @inspection_result.build_check
        @measurement = @inspection_result.build_measurement
        @note = @inspection_result.build_note
      else
        @inspection_result = @inspection_schedule.result
      end
    else # ここには来ない筈。万一の場合のために menu に戻ってメッセージを出すようにしておく。
        redirect_to root_path, notice: t('controllers.system_errors.can_not_start_inspection')
    end
  end

  # GET /inspection_schedules/1/done_inspection
  def done_inspection
    @inspection_result = @inspection_schedule.result
  end

  def close_inspection
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

  # 承認の登録
  def approve_inspection
    @approval = @inspection_schedule.result.build_approval
    @approval.signature = params[:sign]

    @inspection_schedule.approve_inspection

    respond_to do |format|
      if @inspection_schedule.save && @approval.save
        format.html { redirect_to inspection_schedule_url, notice: "InspectionSchedule was successfully approved." }
        format.json { head :no_content }
      else
        format.html { render :done_inspection }
        format.json { render json: @inspection_schedule.errors, status: :unprocessable_close }
      end
    end
  end

  # 完了の登録
  def complete_inspection

    @inspection_schedule.close_inspection

    respond_to do |format|
      if @inspection_schedule.save
        format.html { redirect_to inspection_schedule_url, notice: "InspectionSchedule was successfully closed." }
        format.json { head :no_content }
      else
        format.html { render :done_inspection }
        format.json { render json: @inspection_schedule.errors, status: :unprocessable_close }
      end
    end
  end

  private

  def set_query_to_params
    params[:q] ||= {}
  end

  def set_inspection_schedules
    @search = InspectionSchedule.search(params[:q])
    @inspection_schedules = my_schedules.order_by_target_yearmonth.page(params[:page])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_inspection_schedule
    @inspection_schedule = InspectionSchedule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inspection_schedule_params
    params.require(:inspection_schedule).permit(
      :target_yearmonth, :equipment_id, :service_id, :schedule_status_id, :processingdate
    )
  end

  # 表示する点検予定を返す
  def my_schedules
    # YES本社: 検索結果の点検予定
    if current_user.head_employee?
      return @search.result.order_by_target_yearmonth
    end

    # YES拠点: 管轄のサービス会社の点検予定
    if current_user.branch_employee?
      return InspectionSchedule.with_service_companies(current_user.jurisdiction_services)
    end

    # サービス会社: 自身のサービス会社の点検予定
    if current_user.service_employee?
      return InspectionSchedule.with_service_companies(current_user.company)
    end
  end
end
