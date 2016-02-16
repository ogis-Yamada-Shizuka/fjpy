class CreateInspectionSchedules < ActiveRecord::Migration
  def change
    create_table :inspection_schedules do |t|
      t.datetime :candidate_datetime1
      t.datetime :candidate_datetime2
      t.datetime :candidate_datetime3
      t.text :candidate_datetime_memo
      t.datetime :target_datetime
      t.text :target_datetime_memo
      t.string :author
      t.string :customer
      t.references :equipment, index: true
      t.references :status, index: true
      t.references :service, index: true
      t.references :result_status, index: true
      t.date :processingdate

      t.timestamps
    end
  end
end
