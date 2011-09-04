class AddParametersToZone < ActiveRecord::Migration
  def self.up
    add_column :zones, :width, :integer
    add_column :zones, :height, :integer
  end

  def self.down
    remove_column :zones, :height
    remove_column :zones, :width
  end
end
