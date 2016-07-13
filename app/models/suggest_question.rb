class SuggestQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :suggest_answer, dependent: :destroy
end
