class Subject < ActiveRecord::Base
  include Pretty_URL
  
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy

  validates :name, presence: true
  validates :question_number, presence: true
  validates :duration, presence: true

  after_save :should_generate_new_friendly_id?

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name,
      [:name, :question_number],
      [:name, :question_number, :duration]
    ]
  end
end
