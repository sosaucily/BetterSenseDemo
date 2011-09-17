class AddHtmlSrcToAd < ActiveRecord::Migration
  def self.up
    add_column :ads, :html_src, :text
  end

  def self.down
    remove_column :ads, :html_src
  end
end
