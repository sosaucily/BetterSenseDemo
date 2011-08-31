class Network < ActiveRecord::Base
  belongs_to :account
  belongs_to :network_type
end
