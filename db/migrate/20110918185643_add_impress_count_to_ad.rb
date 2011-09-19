class AddImpressCountToAd < ActiveRecord::Migration
  def self.up
    add_column :ads, :impress_count, :integer
  end

  def self.down
    remove_column :ads, :impress_count
  end
end
