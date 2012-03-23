class CreateTrafficWatchers < ActiveRecord::Migration
  def self.up
    create_table :traffic_watchers do |t|
      t.string :source_ip
      t.string :session_id
      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :traffic_watchers
  end
end
