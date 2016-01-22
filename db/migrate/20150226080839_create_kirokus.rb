class CreateKirokus < ActiveRecord::Migration
  def change
    create_table :kirokus do |t|
      t.references :inspection, index: true
      t.references :worker, index: true
      t.decimal :latitude, precision: 11, scale: 8, null: true
      t.decimal :longitude, precision: 11, scale: 8, null: true

      t.timestamps
    end
  end
end
