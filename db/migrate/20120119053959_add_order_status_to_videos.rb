class AddOrderStatusToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :order_status, :string
  end

  def self.down
    remove_column :videos, :order_status
  end
end
