class SessionsController < ApplicationController

  def index
    redirect_to login_path
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && 
       user.authenticate(params[:session][:password]) &&
       !user.is_blocked?
      sign_in user, params[:session][:remember_me]
      redirect_to downloads_path
    else
      @session_errors = [ 'Invalid email/password combination' ]
      render 'static_pages/login'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
