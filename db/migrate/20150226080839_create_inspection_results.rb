class CreateInspectionResults < ActiveRecord::Migration
  def change
    create_table :inspection_results do |t|
      t.references :inspection_schedule, index: true
      t.references :user, index: true
      t.decimal :latitude, precision: 11, scale: 8, null: true
      t.decimal :longitude, precision: 11, scale: 8, null: true
      t.date :processingdate

      t.timestamps
    end
  end
end
