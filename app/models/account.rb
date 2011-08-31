class Account < ActiveRecord::Base
  has_many :networks
  has_many :videos
end
