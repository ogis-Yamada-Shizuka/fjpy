class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :code
      t.string :name
      t.string :type, index: true

      t.timestamps
    end
  end
end
