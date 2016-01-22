class Equipment < ActiveRecord::Base
  belongs_to :type
  belongs_to :place
  belongs_to :division

  has_many :inspections

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

    equipment_list = Inspection.old_inspection_equipment_list

    Equipment.includes(:inspections)
             .references(:inspections)
             .where(Inspection.arel_table[:equipment_id].eq(nil)
             .or(Inspection.arel_table[:equipment_id].in(equipment_list)))
  end

end
