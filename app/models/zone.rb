class Zone < ActiveRecord::Base

  belongs_to :account
  belongs_to :zone_type
  has_many :ads

  validates :account, :account_exists => true

end
