class Result < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  belongs_to :answer
  belongs_to :other_answer
end
