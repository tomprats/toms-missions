class ApplicationMailerPreview < ActionMailer::Preview
  private
  def user
    User.find_by(email: "tprats108@gmail.com")
  end
end
