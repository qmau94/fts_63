class OtherAnswer < ActiveRecord::Base
  belongs_to :question

  has_many :results, dependent: :destroy
end
