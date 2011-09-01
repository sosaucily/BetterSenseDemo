class Ad < ActiveRecord::Base
  belongs_to :zone
  belongs_to :account
  belongs_to :ad_set

  validate :ensure_account_exists

  def ensure_account_exists
    errors.add('account') unless Account.find_by_id(self.account_id)
  end

end
