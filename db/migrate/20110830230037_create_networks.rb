class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks do |t|
      t.string :name
      t.references :account
      t.references :network_type

      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end
