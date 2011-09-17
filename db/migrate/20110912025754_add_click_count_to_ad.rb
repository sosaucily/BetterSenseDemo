class AddClickCountToAd < ActiveRecord::Migration
  def self.up
    add_column :ads, :click_count, :integer
  end

  def self.down
    remove_column :ads, :click_count
  end
end
