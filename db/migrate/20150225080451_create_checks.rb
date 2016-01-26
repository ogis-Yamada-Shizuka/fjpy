class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.references :weather, index: true
      t.integer :exterior_id
      t.integer :tone_id
      t.integer :stain_id
      t.integer :inspection_result_id

      t.timestamps
    end
  end
end
