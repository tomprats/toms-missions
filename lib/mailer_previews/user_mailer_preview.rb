class UserMailerPreview < ApplicationMailerPreview
  def token
    UserMailer.token(user)
  end
end
