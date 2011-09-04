class Iqeinfo < ActiveRecord::Base
  belongs_to :video

  named_scope :ordered, lambda {|*args| {:order => (args.first || 'created_at DESC')} }

end
