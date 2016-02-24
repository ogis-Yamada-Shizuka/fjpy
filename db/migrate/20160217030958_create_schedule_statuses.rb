class CreateScheduleStatuses < ActiveRecord::Migration
  def change
    create_table :schedule_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
