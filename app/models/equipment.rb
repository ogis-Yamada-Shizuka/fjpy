class Equipment < ActiveRecord::Base
  belongs_to :system_model
  belongs_to :place
  belongs_to :company

  has_many :inspection_schedules

  # CSV Upload
  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, encoding: "SJIS:UTF-8", headers: true) do |row|
      model = find_by_id(row["id"]) || new
      model.attributes = row.to_hash.slice(*column_names)
      model.save!
    end
  end

  def self.no_inspection_list

    equipment_list = InspectionSchedule.old_inspection_equipment_list

    Equipment.includes(:inspection_schedules)
             .references(:inspection_schedules)
             .where(InspectionSchedule.arel_table[:equipment_id].eq(nil)
             .or(InspectionSchedule.arel_table[:equipment_id].in(equipment_list)))
  end

end
