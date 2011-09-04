class Player < ActiveRecord::Base
  belongs_to :account
  belongs_to :player_type

  validates :account, :account_exists => true
end
