class CreateNetworkTypes < ActiveRecord::Migration
  def self.up
    create_table :network_types do |t|
      t.string :name
      t.string :company_url
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :network_types
  end
end
