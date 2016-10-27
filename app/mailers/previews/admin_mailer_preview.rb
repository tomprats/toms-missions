class AdminMailerPreview < ApplicationMailerPreview
  def new_user
    AdminMailer.new_user(user, user)
  end
end
