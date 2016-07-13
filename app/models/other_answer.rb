class OtherAnswer < ActiveRecord::Base
  belongs_to :question

  has_many :result, dependent: :destroy
end
