class Result < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  belongs_to :other_answer
  serialize :multiple_answers

  scope :correct, ->{where state: true}

  def check_state
    if multiple_answers.count == count_correct_answer
      state = true
      multiple_answers.collect.each do |id|
        unless question.answers.find_by(id: id).is_correct
          update_attributes state: false
          return
        end
      end
    else
      state = false
    end
    update_attributes state: state if state
  end

  private
  def count_correct_answer
    question.answers.correct.count
  end
end
