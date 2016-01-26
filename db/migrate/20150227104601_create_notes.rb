class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :inspection_result, index: true
      t.text :memo
      t.string :picture

      t.timestamps
    end
  end
end
