class CreateSystemModels < ActiveRecord::Migration
  def change
    create_table :system_models do |t|
      t.string :name
      t.integer :inspection_cycle_month

      t.timestamps
    end
  end
end
