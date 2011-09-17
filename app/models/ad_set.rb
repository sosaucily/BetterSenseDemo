class AdSet < ActiveRecord::Base
  belongs_to :video
  belongs_to :account
  has_many :ads
  

  validates :account, :account_exists => true

end
