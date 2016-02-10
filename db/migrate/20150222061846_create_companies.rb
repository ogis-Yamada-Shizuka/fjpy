class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :code
      t.string :name
      t.references :branch, index: true
      t.string :type, index: true

      t.timestamps
    end
  end
end
