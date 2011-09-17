class AddIqeinfoIdToAds < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.references :iqeinfo
    end
  end

  def self.down
    remove_column :ads, :iqeinfo_id
  end
end
