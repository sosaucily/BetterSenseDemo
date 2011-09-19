class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.decimal :budget, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
