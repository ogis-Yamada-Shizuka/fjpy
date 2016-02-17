class InspectionSchedule < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :service
  belongs_to :schedule_status
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

  # 装置システムの点検予定をまとめて作成
  def self.bulk_create(params, current_date)
    params.targets.try(:map) do |equipment_id|
      if User.exists?(id: params.user_id)
        new_inspection_schedule = new(
          target_yearmonth: params.target_yearmonth,
          equipment_id: equipment_id,
          user_id: params.user_id,
          schedule_status_id: ScheduleStatus.of_requested,
          processingdate: current_date
        )
        new_inspection_schedule.save
      else
        false
      end
    end
  end

  # 拠点が管轄する装置システムの点検予定を作成する
  #   target_brahch_id 点検予定を作成する対象の拠点
  #   target_year      点検予定作成対象の年
  #   target_month     点検予定作成対象の月
  def self.make_branch_yyyym(target_brahch_id, target_year, target_month, current_date)
    equipments = Equipment.where(branch_id: target_brahch_id)
    equipments.each do |equipment|
      if equipment.is_inspection_datetime(target_year, target_month) && # 該当装置システムの点検年月にあたる
         !equipment.exist_inspection(target_year, target_month)          # 該当年月の点検スケジュールが未だ無い
        new_inspection_schedule = new(
          target_yearmonth: target_year+target_month,
          equipment_id: equipment.id,
          service_id: equipment.service_id,
          schedule_status_id: ScheduleStatus.of_requested,
          processingdate: current_date
        )
        new_inspection_schedule.save
      end
    end
  end

  # InspectionSchedule のステータス変更
  # TODO: 後で全ケース作る

  # 点検中に変更
  def start_inspection
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4 start_inspection"
    self.schedule_status.id = ScheduleStatus.of_in_progress
  end

  # 完了に変更
  def close_inspection
    self.schedule_status.id = ScheduleStatus.of_completed
    self.processingdate = current_date
  end

  # 点検中(doing)かどうか
  def doing?
    if schedule_status.id == ScheduleStatus.of_in_progress
      true
    else
      false
    end
  end

  # 完了している状態かどうか
  def close?
    if schedule_status.id == ScheduleStatus.of_completed
      true
    else
      false
    end
  end

  # 点検開始して良いかどうか
  def can_inspection?
    if schedule_status.id == ScheduleStatus.of_in_progress or 
       schedule_status.id == ScheduleStatus.of_dates_confirmed
      true
    else
      false
    end
  end

  def place
    equipment.place
  end

  def result_name
    result.try(:schedule_status).try(:name)
  end

  def target
    target_yearmonth.strftime("%Y年%m月")
  end
end
