class AddAccountIdToVideo < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.references :account
    end
  end

  def self.down
    remove_column :videos, :account_id
  end
end
