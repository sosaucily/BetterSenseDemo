class Iqeinfo < ActiveRecord::Base
  belongs_to :video
  belongs_to :ads

  scope :ordered, lambda {|*args| {:order => (args.first || 'created_at DESC')} }

end
