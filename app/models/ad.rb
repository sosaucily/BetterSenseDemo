class Ad < ActiveRecord::Base
  belongs_to :zone
  belongs_to :account
  belongs_to :ad_set
  belongs_to :advertiser

  has_attached_file :ad_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :account, :account_exists => true

end
