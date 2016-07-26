class SuggestQuestion < ActiveRecord::Base
  after_update :create_question, if: :approved

  belongs_to :user
  belongs_to :subject

  has_many :suggest_answers, dependent: :destroy
  
  validates :question, presence: true
  
  accepts_nested_attributes_for :suggest_answers, allow_destroy: true
  enum question_type: [:single_choice, :multiple_choice, :text]


  enum approve: ["wait", "approve", "reject"]

  scope :by_user, ->user {where user_id: user.id}

  private
  def approved
    self.approve_changed?(from: "wait", to: "approve")
  end

  def create_question
    Question.create question: self.question, question_type: self.question_type,
      subject_id: self.subject_id
  end
end
