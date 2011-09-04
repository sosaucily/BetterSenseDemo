class Network < ActiveRecord::Base
  belongs_to :account
  belongs_to :network_type

  validates :account, :account_exists => true
end
