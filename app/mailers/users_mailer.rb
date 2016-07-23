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

  def mail_month user_id
    @user = User.find_by id: user_id
    @exams = @user.exams
    scores = @exams.collect {|exam| exam.score}
    total = scores.inject {|sum, v| sum + v}.to_f
    count = scores.count
    @average = (total / count).to_s.html_safe
    mail to: @user.email, subject: t("mail.average")
  end
end
