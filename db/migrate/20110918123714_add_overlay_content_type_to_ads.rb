class AddOverlayContentTypeToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :overlay_content_type, :string
  end

  def self.down
    remove_column :ads, :overlay_content_type
  end
end
