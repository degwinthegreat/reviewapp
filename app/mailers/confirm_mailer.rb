class ConfirmMailer < ApplicationMailer
  def confirm_mailer(user, citicize)
    @content = citicize.content
    @user = user

    mail to: @user.email, subject: "投稿しました"
  end
end
