class CreateZoneTypes < ActiveRecord::Migration
  def self.up
    create_table :zone_types do |t|
      t.string :name
      t.integer :width
      t.text :description
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :zone_types
  end
end
