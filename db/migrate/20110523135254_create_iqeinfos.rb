class CreateIqeinfos < ActiveRecord::Migration
  def self.up
    create_table :iqeinfos do |t|
      t.text :results
      t.integer :videotimemillis
      t.string :hashstring
      t.string :matcheditem
      t.string :colors
      t.string :imagepath
      t.references :video

      t.timestamps
    end
  end

  def self.down
    drop_table :iqeinfos
  end
end
