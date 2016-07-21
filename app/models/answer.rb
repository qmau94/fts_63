class Answer < ActiveRecord::Base
  belongs_to :question

  scope :correct, ->{where is_correct: true}
end
