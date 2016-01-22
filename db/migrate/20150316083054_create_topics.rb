class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :name
      t.text :description
      t.references :flag, index: true

      t.timestamps
    end
  end
end
