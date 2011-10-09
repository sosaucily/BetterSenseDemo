class AddAccountIdToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.references :account
    end
  end

  def self.down
    remove_column :users, :account_id
  end
end
