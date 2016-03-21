class Equipment < ActiveRecord::Base
  include Common

  belongs_to :system_model
  belongs_to :place
  belongs_to :branch
  belongs_to :service

  has_many :inspection_schedules

  validates :serial_number, presence: true, uniqueness: { scope: :system_model }
  validates :serial_number, format: { with: /\A[A-Z0-9-]+\z/, message: "は半角英数字とハイフンのみで記入して下さい" }
  after_create :create_inspection_schedule, if: -> { inspection_contract }
  after_save :create_inspection_schedule, if: :contracted?
  after_save :destroy_inspection_schedule, if: :discarded_contract?

  # CSV Upload
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, encoding: 'SJIS:UTF-8', headers: true) do |row|
      model = find_by_id(row['id']) || new
      model.attributes = row.to_hash.slice(*column_names)
      model.save!
    end
  end

  def create_inspection_schedule
    InspectionSchedule.create(
      target_yearmonth: first_inspection_cycle,
      equipment: self,
      service: service,
      schedule_status_id: ScheduleStatus.of_need_request
    )
  end

  def destroy_inspection_schedule
    InspectionSchedule.where(equipment: self, schedule_status_id: ScheduleStatus.of_need_request).delete_all
  end

  def self.bulk_change_inspection_cycle(target_list, new_inspection_cycle_month)
    target_list.each do |key, val|
      next unless val == '1'
      equipment = Equipment.where(id: key).first
      equipment.inspection_cycle_month = new_inspection_cycle_month
      equipment.save
    end
  end

  # 次回の点検予定
  def next_inspection_schedule
    inspection_schedules.not_done.order_by_target_yearmonth.first
  end

  private

  def first_inspection_cycle
    today = Date.parse(current_date)
    first_inspection_day = Date.parse(start_date.to_s[0..9]) >> inspection_cycle_month
    (today < first_inspection_day) ? first_inspection_day : today
  end

  def contracted?
    changed.include?('inspection_contract') && inspection_contract
  end

  def discarded_contract?
    changed.include?('inspection_contract') && !inspection_contract
  end
end
