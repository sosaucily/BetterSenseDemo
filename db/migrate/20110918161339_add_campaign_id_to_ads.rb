class AddCampaignIdToAds < ActiveRecord::Migration
 def self.up
    change_table :ads do |t|
      t.references :campaign
    end
  end

  def self.down
    remove_column :ads, :campaign_id
  end
end
