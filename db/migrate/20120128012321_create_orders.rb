class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :email
      t.string :pay_type
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
