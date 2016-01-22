class RemoveColumnsFromChecks < ActiveRecord::Migration
  def change
    remove_column :checks, :exterior, :integer
    remove_column :checks, :tone, :integer
    remove_column :checks, :stain, :integer
  end
end
