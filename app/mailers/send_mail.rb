class SendMail < ActionMailer::Base
  default from: "ideas.managment.sys@gmail.com"

  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: 'Reset Password')
  end
end
