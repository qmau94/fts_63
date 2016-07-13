class Question < ActiveRecord::Base
  belongs_to :subject

  has_many :result, dependent: :destroy
  has_many :answer, dependent: :destroy
  has_many :other_answer, dependent: :destroy
end
