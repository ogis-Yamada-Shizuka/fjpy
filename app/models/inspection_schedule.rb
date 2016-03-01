class InspectionSchedule < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :service
  belongs_to :schedule_status
  belongs_to :user
  alias_attribute :status, :schedule_status
  has_one :result, class_name: 'InspectionResult'

  include Common
  after_commit :dump

  scope :old_inspection_equipments, lambda { |limit_date|
    group(:equipment_id).having("max(target_yearmonth) < '#{limit_date.strftime('%Y%m')}'")
  }

  scope :not_done, -> { includes(:schedule_status).where(schedule_status_id: ScheduleStatus.not_done_ids) }
  scope :with_service_companies, ->(service_companies) {
    includes(equipment: :place).where(service: service_companies)
  }
  scope :with_place, ->(place) { joins(equipment: :place).where('equipment.place_id = ?', place.id) }
  scope :order_by_target_yearmonth, -> { order(:target_yearmonth, :id) }

  # InspectionSchedule上に、1年前以前の情報しかないequipment_idの一覧を取得。
  # TODO: 点検周期を過ぎた情報にする equipment_id にする必要があるはず。
  def self.old_inspection_equipment_list
    InspectionSchedule.select("equipment_id, max(target_yearmonth) ")
                      .old_inspection_equipments(Time.zone.now.prev_year)
                      .pluck(:equipment_id)
  end

  ###
  # ステータス変更シリーズ
  # TODO: 後で全ケース作る
  ###

  # 点検実施中に変更
  def start_inspection
    self.schedule_status_id = ScheduleStatus.of_in_progress
    self.processingdate = current_date
  end

  # 顧客承認済みに変更
  def approve_inspection
    self.schedule_status_id = ScheduleStatus.of_approved
    self.processingdate = current_date
  end

  # 完了に変更 ＆ 次回の点検予定を自動的に登録
  def close_inspection
    self.schedule_status_id = ScheduleStatus.of_completed
    self.processingdate = current_date
  end

  # 指定された年月で次回の点検予定を作成する
  def create_next_inspection_schedule(yearmonth)
    InspectionSchedule.create(
      target_yearmonth: yearmonth,
      equipment: equipment,
      service: service,
      schedule_status_id: ScheduleStatus.of_requested
    )
  end

  # 候補日時回答して良いかどうか
  def can_answer_date?(user = nil)
    return false unless (user.try(:branch_employee?) || user.try(:service_employee?))
    schedule_status_id == ScheduleStatus.of_requested
  end

  # 日程確定して良いかどうか
  def can_confirm_date?(user = nil)
    return false unless user.try(:branch_employee?)
    schedule_status_id == ScheduleStatus.of_date_answered
  end

  # 点検開始して良いかどうか
  def can_inspection?(user = nil)
    return false unless user.try(:service_employee?)
    (schedule_status_id == ScheduleStatus.of_in_progress && result.blank?) or
    schedule_status_id == ScheduleStatus.of_dates_confirmed
  end

  # 点検中(doing)かどうか
  def doing?(user = nil)
    schedule_status_id == ScheduleStatus.of_in_progress
  end

  # 承認して良いかどうか
  def can_approval?(user = nil)
    return false unless user.try(:service_employee?)
    doing?
  end

  # 点検を完了できるかどうか(顧客の承認がされている状態なら完了できる)
  def can_close_inspection?(user = nil)
    return false unless user.try(:branch_employee?)
    schedule_status_id == ScheduleStatus.of_approved
  end

  # 完了している状態かどうか
  def close?(user = nil)
    schedule_status_id == ScheduleStatus.of_completed
  end

  def place
    equipment.place
  end

  # TODO: result_name 誰も使っていないなら消す
  def result_name
    result.try(:schedule_status).try(:name)
  end

  def target
    target_yearmonth.try(:strftime, "%Y年%m月")
  end

  # 処理日と装置システムの型式に設定された点検周期をもとに次回点検予定の候補年月を答える
  def next_target_yearmonth
    processingdate >> equipment.system_model.inspection_cycle_month
  end
end
