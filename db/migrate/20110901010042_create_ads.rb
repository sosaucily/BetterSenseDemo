class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.string :name
      t.text :description
      t.references :zone_id
      t.string :image_url
      t.integer :time_millis
      t.integer :duration_millis
      t.references :ad_set_id
      t.references :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
