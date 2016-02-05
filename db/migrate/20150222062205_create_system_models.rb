class CreateSystemModels < ActiveRecord::Migration
  def change
    create_table :system_models do |t|
      t.string :name

      t.timestamps
    end
  end
end
