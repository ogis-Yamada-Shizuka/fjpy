class CreateInfomsgs < ActiveRecord::Migration
  def change
    create_table :infomsgs do |t|
      t.date :effective_date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
