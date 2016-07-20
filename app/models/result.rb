class Result < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  belongs_to :other_answer
  serialize :multiple_answers
end
