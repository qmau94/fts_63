class Question < ActiveRecord::Base
  belongs_to :subject

  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :other_answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true

  enum question_type: [:single_choice, :multiple_choice, :text]

  validates :question, presence: true
end
