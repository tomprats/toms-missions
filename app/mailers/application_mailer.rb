class ApplicationMailer < ActionMailer::Base
  default from: "Tom's Missions <notify@tomify.me>"
  layout "mailer"
end
