class AddAccountIdToCampaigns < ActiveRecord::Migration
  def self.up
    change_table :campaigns do |t|
      t.references :account
    end
  end

  def self.down
    remove_column :campaigns, :account_id
  end
end
