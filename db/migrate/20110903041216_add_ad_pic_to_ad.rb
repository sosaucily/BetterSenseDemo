class AddAdPicToAd < ActiveRecord::Migration
  def self.up
    add_column :ads, :ad_pic_file_name,    :string
    add_column :ads, :ad_pic_content_type, :string
    add_column :ads, :ad_pic_file_size,    :integer
    add_column :ads, :ad_pic_updated_at,   :datetime
    add_column :ads, :ad_pic_fingerprint, :string
  end

  def self.down
    remove_column :ads, :ad_pic_file_name
    remove_column :ads, :ad_pic_content_type
    remove_column :ads, :ad_pic_file_size
    remove_column :ads, :ad_pic_updated_at
    remove_column :ads, :ad_pic_fingerprint
  end
end
