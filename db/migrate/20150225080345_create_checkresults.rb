class CreateCheckresults < ActiveRecord::Migration
  def change
    create_table :checkresults do |t|
      t.string :name

      t.timestamps
    end
  end
end
