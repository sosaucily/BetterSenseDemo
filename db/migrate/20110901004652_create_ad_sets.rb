class CreateAdSets < ActiveRecord::Migration
  def self.up
    create_table :ad_sets do |t|
      t.string :name
      t.references :video
      t.references :account

      t.timestamps
    end
  end

  def self.down
    drop_table :ad_sets
  end
end
