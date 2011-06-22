class SessionsController < ApplicationController
  def new
    if user = User.authenticate(params[:name],params[:password])
      session[:user_id] = user.id
      redirect_to videos_url
    else
      redirect_to login_url, :alert => "Invalid user or password."
    end
  end

  def create
  end

  def destroy
    session[:user_id] = nil
    redirect_to videos_url, :notice => "You have successfully logged out."
  end

end
