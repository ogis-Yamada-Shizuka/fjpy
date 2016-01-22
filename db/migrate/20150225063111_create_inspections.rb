class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.string :targetyearmonth
      t.references :equipment, index: true
      t.references :status, index: true
      t.references :worker, index: true
      t.references :result, index: true
      t.date :processingdate

      t.timestamps
    end
  end
end
