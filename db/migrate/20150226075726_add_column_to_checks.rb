class AddColumnToChecks < ActiveRecord::Migration
  def change
    add_column :checks, :kiroku_id, :integer
  end
end
