class TestMailer < ApplicationMailer
  def welcome_email
    mail(to: 'nicoleokamoto@icloud.com', subject: 'Welcome to My Site') do |format|
      format.text { render plain: "Hello, World!" }
    end
  end
end
