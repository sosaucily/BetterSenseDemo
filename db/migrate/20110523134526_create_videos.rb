class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name
      t.integer :lengthmillis
      t.string :description
      t.string :hashstring

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
