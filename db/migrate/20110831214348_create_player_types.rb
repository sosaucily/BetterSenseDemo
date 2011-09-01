class CreatePlayerTypes < ActiveRecord::Migration
  def self.up
    create_table :player_types do |t|
      t.string :name
      t.text :description
      t.string :player_url
      t.string :version

      t.timestamps
    end
  end

  def self.down
    drop_table :player_types
  end
end
