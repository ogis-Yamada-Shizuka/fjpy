class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name
      t.references :division, index: true

      t.timestamps
    end
  end
end
