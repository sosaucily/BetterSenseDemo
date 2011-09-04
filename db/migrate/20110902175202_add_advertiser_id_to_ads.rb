class AddAdvertiserIdToAds < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.references :advertiser
    end
  end

  def self.down
    remove_column :ads, :advertiser_id
  end
end
