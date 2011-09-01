class Network < ActiveRecord::Base
  belongs_to :account
  belongs_to :network_type

  validate :ensure_account_exists

  def ensure_account_exists
    errors.add('account') unless Account.find_by_id(self.account_id)
  end
end
