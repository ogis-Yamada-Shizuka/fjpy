class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.references :weather, index: true
      t.integer :exterior
      t.integer :tone
      t.integer :stain

      t.timestamps
    end
  end
end
