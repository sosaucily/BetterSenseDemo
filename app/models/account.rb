class Account < ActiveRecord::Base
  has_many :networks, :dependent => :destroy
  has_many :videos
  has_many :zones, :dependent => :destroy
  has_many :players, :dependent => :destroy
  has_many :ad_sets, :dependent => :destroy
  has_many :ads, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :campaigns, :dependent => :destroy
end
