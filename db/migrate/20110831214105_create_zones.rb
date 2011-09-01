class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.string :name
      t.text :description
      t.references :zone_type
      t.references :account

      t.timestamps
    end
  end

  def self.down
    drop_table :zones
  end
end
