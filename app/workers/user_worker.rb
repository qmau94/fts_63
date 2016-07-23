class UserWorker
  include Sidekiq::Worker

  START_EXAM = 1
  FINISH_EXAM = 2

  def perform action, user_id, exam_id
    case action
    when START_EXAM
      send_email_when_start_exam user_id, exam_id
    when FINISH_EXAM
      send_email_when_finish_exam user_id, exam_id
    when AVERAGE_SCORE
      send_email_average_score user_id, exam_id
    end
  end

  private
  def send_email_when_start_exam user_id, exam_id
    user = User.find_by id: user_id
    exam = Exam.find_by id: exam_id
    UsersMailer.start_to_exam(user, exam).deliver
  end

  def send_email_when_finish_exam user_id, exam_id
    user = User.find_by id: user_id
    exam = Exam.find_by id: exam_id
    UsersMailer.finish_to_exam(user, exam).deliver
  end
end
