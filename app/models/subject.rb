class Subject < ActiveRecord::Base
  has_many :exam, dependent: :destroy
  has_many :question, dependent: :destroy
  has_many :suggest_question, dependent: :destroy
end
