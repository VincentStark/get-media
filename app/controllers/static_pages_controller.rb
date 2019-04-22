class StaticPagesController < ApplicationController

  def index
    if signed_in?
      redirect_to users_path
    else
      redirect_to login_path
    end
  end
end
