class User < ActiveRecord::Base
  has_many :exam, dependent: :destroy
end
