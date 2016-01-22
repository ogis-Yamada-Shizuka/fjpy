class AddColumnsToChecks < ActiveRecord::Migration
  def change
    add_column :checks, :exterior_id, :integer
    add_column :checks, :tone_id, :integer
    add_column :checks, :stain_id, :integer
  end
end
