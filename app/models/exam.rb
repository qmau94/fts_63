class Exam < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :user
  belongs_to :subject

  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :results, allow_destroy: true

  enum status: ["init", "testing", "uncheck", "checked"]

  def create_result_for_exam
    Result.transaction do
      begin
        unless results.any?
          subject.questions.random.limit(
            subject.question_number).each do |question|
              question.results.create! exam: self,multiple_answers: []
          end
          update_time_status
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  def update_time_status
    if init?
      update_attributes started_at: Time.zone.now, status: :testing
    elsif time_out? && testing?
      update_attributes status: :uncheck
    elsif testing?
      update_attributes spent_time: calculated_spent_time
    end
  end

  def time_out?
    uncheck? || checked? || Time.zone.now > started_at + subject.duration
  end

  def remaining_time
    init? || testing? ? subject.duration - (Time.zone.now - started_at).to_i : 0
  end

  def calculated_spent_time
    time = Time.zone.now - started_at
    time > subject.duration ? subject.duration : time
  end

  def update_results
    results.each do |r|
      r.check_state
    end
  end
end
