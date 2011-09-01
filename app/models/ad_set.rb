class AdSet < ActiveRecord::Base
  belongs_to :video
  belongs_to :account
  has_many :ads

  validate :ensure_account_exists

  def ensure_account_exists
    errors.add('account') unless Account.find_by_id(self.account_id)
  end

end
