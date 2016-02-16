class CreateInspectionSchedules < ActiveRecord::Migration
  def change
    create_table :inspection_schedules do |t|
      t.string :targetyearmonth
      t.references :equipment, index: true
      t.references :status, index: true
      t.references :service, index: true
      t.references :result_status, index: true
      t.date :processingdate

      t.timestamps
    end
  end
end
