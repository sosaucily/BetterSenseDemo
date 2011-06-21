class AddResolutionToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :res_x, :integer, :default => 480
    add_column :videos, :res_y, :integer, :default => 360
  end

  def self.down
    remove_column :videos, :res_y
    remove_column :videos, :res_x
  end
end
