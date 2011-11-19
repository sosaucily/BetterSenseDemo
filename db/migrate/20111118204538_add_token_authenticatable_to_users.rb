class AddTokenAuthenticatableToUsers < ActiveRecord::Migration

  def self.up
    change_table :users do |t|
      t.token_authenticatable
    end
    add_index :users, :authentication_token, :unique => true
  end

  def self.down
    remove_column :users, :token_authenticatable
    remove_index :users, :authentication_token
  end


end
