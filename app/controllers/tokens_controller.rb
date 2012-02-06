# This is part of the BetterSense Web system
#
# Author::    Jesse Smith  (mailto:js@bettersense.com)
# Copyright:: Copyright (c) 2011 BetterSense

require 'digest/sha1'
  
class TokensController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :check_session
  
  def index
    id = session[:account_id]
    @user = User.find(id)
    if (params.has_key? "destroy_key") then
      @user.authentication_token = nil
      @user.secret_key = nil
      @user.save
    end

    @token = @user.authentication_token
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  #We generate a secret hash based on a random 20 b64 values.  
  #This is stored in the DB as the SHA1 hash and compared during API calls.
  #This is a layer on top of Devise auth_token for added security
  def generate
    #This is an account ID, not a user id...
    id = session[:account_id]
    @user = User.find(id)
    @user.reset_authentication_token!
    @token = @user.authentication_token
    @secret = ActiveSupport::SecureRandom.urlsafe_base64(20)
    @secret_key = Digest::SHA1.hexdigest @secret
    @user.secret_key = @secret_key
    @user.save
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end