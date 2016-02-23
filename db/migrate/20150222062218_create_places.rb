class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :address
      t.belongs_to :branch, index: true

      t.timestamps
    end
  end
end
