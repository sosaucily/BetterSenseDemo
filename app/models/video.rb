class Video < ActiveRecord::Base
  has_many :iqeinfos
  has_many :ad_sets
  belongs_to :account

  has_attached_file :vid_file

  validates :account, :account_exists => true

  include VideosHelper

end
