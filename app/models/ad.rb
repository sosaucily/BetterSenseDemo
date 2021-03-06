class Ad < ActiveRecord::Base
  belongs_to :zone
  belongs_to :account
  belongs_to :ad_set
  belongs_to :advertiser
  belongs_to :campaign
  has_many :iqeinfos

  has_attached_file :ad_pic, :styles => { :medium => "300x300>", :thumb => "160x120>" }

  validates :account, :account_exists => true

end
