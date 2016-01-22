class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.references :inspection, index: true
      t.binary :signature

      t.timestamps
    end
  end
end
