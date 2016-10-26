class AdminMailer < ApplicationMailer
  def new_user(admin, user)
    @admin = admin
    @user = user
    @user_url = user_url(user.username)

    mail(to: @admin.email, subject: "Tom's Missions - #{@user.name} Registered")
  end
end
