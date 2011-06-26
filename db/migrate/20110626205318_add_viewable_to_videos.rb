class AddViewableToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :viewable, :boolean, :default => false
  end

  def self.down
    remove_column :videos, :viewable
  end
end
