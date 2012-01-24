class AddStatusToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :status, :string, :default=>"new"
  end

  def self.down
    remove_column :videos, :status
  end
end
