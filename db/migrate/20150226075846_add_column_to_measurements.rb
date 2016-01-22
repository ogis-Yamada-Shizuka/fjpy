class AddColumnToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :kiroku_id, :integer
  end
end
