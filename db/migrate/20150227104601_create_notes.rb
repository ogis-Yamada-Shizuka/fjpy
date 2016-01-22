class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :kiroku, index: true
      t.text :memo
      t.string :picture

      t.timestamps
    end
  end
end
