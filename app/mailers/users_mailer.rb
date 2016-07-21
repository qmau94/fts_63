class UsersMailer < ActionMailer::Base
  default from: Settings.mail

  def start_to_exam user, exam
    @user = user
    @exam = exam
    mail to: @user.email, subject: t("mail.start")
  end

  def finish_to_exam user, exam
    @user = user
    @exam = exam
    mail to: @user.email, subject: t("mail.finish")
  end
end
