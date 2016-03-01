class Equipment < ActiveRecord::Base
  include Common

  belongs_to :system_model
  belongs_to :place
  belongs_to :branch
  belongs_to :service

  has_many :inspection_schedules

  validates :serial_number, presence: true, uniqueness: { scope: :system_model }
  validates :serial_number, :format => { :with => /\A[A-Z0-9-]+\z/, :message => "は半角英数字とハイフンのみで記入して下さい" }
  after_create :create_inspection_schedule, :if => :inspection_contract

  # CSV Upload
  require "csv"

  def self.import(file)
    CSV.foreach(file.path, encoding: "SJIS:UTF-8", headers: true) do |row|
      model = find_by_id(row["id"]) || new
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

  # 次回の点検予定
  def next_inspection_schedule
    inspection_schedules.not_done.order_by_target_yearmonth.first
  end

  private

  def first_inspection_cycle
    Date.parse(start_date.to_s[0..9]) >> inspection_cycle_month
  end
end
