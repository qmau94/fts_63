class Subject < ActiveRecord::Base
  has_many :exam, dependent: :destroy
  has_many :question, dependent: :destroy
  has_many :suggest_question, dependent: :destroy

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

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
