class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.string :name
      t.text :description
      t.references :zone
      t.string :image_url
      t.integer :time_millis
      t.integer :duration_millis
      t.references :ad_set
      t.references :account

      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
