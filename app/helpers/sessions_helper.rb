module SessionsHelper

  def sign_in(user, remember_user = "0")
    if remember_user == "1"
      cookies.permanent[:remember_token] = user.remember_token
    else
      session[:remember_token] = user.remember_token
    end
    current_user = user
    user.last_login_at = DateTime.now
    user.save(:validate => false)
  end

  def signed_in?
    !current_user.nil? && !current_user.is_blocked?
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
    session[:remember_token] = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    redirect_to login_path, notice: "Please login first." unless signed_in?
  end

  def admin_user
    redirect_to downloads_path unless current_user.is_admin?
  end

  private

    def user_from_remember_token
      if !cookies[:remember_token].nil?
        remember_token = cookies[:remember_token]
      else
        remember_token = session[:remember_token]
      end
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end
end
