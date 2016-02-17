class CreateResultStatuses < ActiveRecord::Migration
  def change
    create_table :result_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
