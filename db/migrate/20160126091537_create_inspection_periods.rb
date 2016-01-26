class CreateInspectionPeriods < ActiveRecord::Migration
  def change
    create_table :inspection_periods do |t|
      # TODO: このテーブルの責務が決まるまで空

      t.timestamps
    end
  end
end
