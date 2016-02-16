class InspectionSchedule < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :status
  belongs_to :service
  belongs_to :result_status
  has_one :result, class_name: 'InspectionResult'

  include Common
  after_commit :dump

  scope :old_inspection_equipments, lambda { |limit_date|
    group(:equipment_id).having("max(target_datetime) < '#{limit_date.strftime('%Y%m')}'")
  }

  scope :not_done, -> { includes(:status).where(status_id: Status.not_done_ids) }
  scope :with_service_companies, ->(service_companies) {
    includes(equipment: :place).where(service: service_companies)
  }
  scope :with_place, ->(place) { joins(equipment: :place).where('equipment.place_id = ?', place.id) }
  scope :order_by_target_datetime, -> { order(:target_datetime, :id) }

  # InspectionSchedule上に、1年前以前の情報しかないequipment_idの一覧を取得。
  # TODO: 点検周期を過ぎた情報にする equipment_id にする必要があるはず。
  def self.old_inspection_equipment_list
    InspectionSchedule.select("equipment_id, max(target_datetime) ")
                      .old_inspection_equipments(Time.zone.now.prev_year)
                      .pluck(:equipment_id)
  end

  # 装置システムの点検予定をまとめて作成
  def self.bulk_create(params, current_date)
    params.targets.try(:map) do |equipment_id|
      if User.exists?(id: params.user_id)
        new_inspection_schedule = new(
          target_datetime: params.target_datetime,
          equipment_id: equipment_id,
          status_id: 1,
          user_id: params.user_id,
          result_status_id: 4,
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
          target_datetime: target_year+target_month,
          equipment_id: equipment.id,
          status_id: Status.of_unallocated,
          service_id: equipment.service_id,
          result_status_id: ResultStatus.of_requested,
          processingdate: current_date
        )
        new_inspection_schedule.save
      end
    end
  end

  # InspectionSchedule のステータス変更
  def start_inspection
    self.status_id = Status.of_doing
  end

  def close_inspection
    self.status_id = Status.of_done
    self.processingdate = current_date
  end

  # Inspection の結果変更
  def judging(inspection_result)
    self.result_status_id =
      inspection_result.check.tone_id != 4 ? ResultStatus.of_completed : ResultStatus.of_ng
    self.processingdate = current_date
  end

  # 点検中(doing)かどうか
  def doing?
    if status.id == Status.of_doing
      true
    else
      false
    end
  end

  # 完了している状態かどうか
  def close?
    if status.id == Status.of_done
      true
    else
      false
    end
  end

  # 点検開始して良いかどうか
  def can_inspection?
    if status.id == Status.of_done
      false # 完了 してたらダメ
    else
      true # 完了してなければ良い（とりあえず）
    end
  end

  def place
    equipment.place
  end

  def result_name
    result.try(:result_status).try(:name)
  end
end
