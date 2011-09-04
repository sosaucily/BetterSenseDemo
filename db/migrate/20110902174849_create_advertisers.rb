class CreateAdvertisers < ActiveRecord::Migration
  def self.up
    create_table :advertisers do |t|
      t.string :fname
      t.string :lname
      t.string :company_name

      t.timestamps
    end
  end

  def self.down
    drop_table :advertisers
  end
end
