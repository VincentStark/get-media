class UserMailer < ActionMailer::Base
  default from: "confirm@getmedia.com"

  def confirm_email(user)
    @user = user
    @confirm_url = "http://starlight:3000/users/confirm?confirm_id=" + user.remember_token
    mail(:to => user.email, :subject => "GetMedia Email Confirmation")
  end
end
