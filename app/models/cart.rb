class Cart < ActiveRecord::Base
  
    belongs_to :account
    has_many :line_items, :dependent => :destroy
end
