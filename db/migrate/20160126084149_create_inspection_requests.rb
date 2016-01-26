class CreateInspectionRequests < ActiveRecord::Migration
  def change
    create_table :inspection_requests do |t|
      t.belongs_to :service, index: true
      t.belongs_to :inspect_schedule, index: true
      t.date :schedule

      t.timestamps
    end
  end
end
