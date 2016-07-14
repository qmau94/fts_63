class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :trackable, :recoverable
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable
  has_many :exam, dependent: :destroy
end
