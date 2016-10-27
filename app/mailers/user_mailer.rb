class UserMailer < ApplicationMailer
  def token(user)
    @user = user

    mail(to: @user.email, subject: "Tom's Missions - Login")
  end
end
