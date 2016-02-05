class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :name
      t.references :system_model, index: true
      t.references :place, index: true
      t.references :branch, index: true
      t.references :service, index: true

      t.timestamps
    end
  end
end
