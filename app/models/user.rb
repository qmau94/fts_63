class User < ActiveRecord::Base
  include Pretty_URL
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable, :omniauthable

  after_save :should_generate_new_friendly_id?

  has_many :exams, dependent: :destroy

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Settings.default_password
        user.username = auth.info.name  
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] && 
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end

  def slug_candidates
    [
      :username,
      [:username, :email]
    ]
  end
end
