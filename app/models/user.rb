class User < ActiveRecord::Base
  belongs_to :account
  
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  private

  def assign_unique_token
    self.secret_key = ActiveSupport::SecureRandom.urlsafe_base64(20)
  end

  
end
