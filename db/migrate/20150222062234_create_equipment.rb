class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :name
      t.references :type, index: true
      t.references :place, index: true
      t.references :division, index: true

      t.timestamps
    end
  end
end
