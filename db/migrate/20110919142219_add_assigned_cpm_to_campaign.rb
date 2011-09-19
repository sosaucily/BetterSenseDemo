class AddAssignedCpmToCampaign < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :assigned_cpm, :decimal
  end

  def self.down
    remove_column :campaigns, :assigned_cpm
  end
end
