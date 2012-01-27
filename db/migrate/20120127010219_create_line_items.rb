class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :video_id
      t.integer :cart_id
      t.string :quality
      t.integer :order_id

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
