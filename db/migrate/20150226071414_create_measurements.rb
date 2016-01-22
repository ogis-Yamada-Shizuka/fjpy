class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :metercount
      t.decimal :testervalue, :precision => 5, :scale => 2
      t.integer :point

      t.timestamps
    end
  end
end
