class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if namespace == "admin"
      if user.is_admin?
        can :read, :all
        can :manage, Subject
        can [:new, :create], Question
        can [:edit, :destroy], User do |other_user|
          user != other_user
        end
      else
        cannot :manage, :all
      end
    else
      if user.is_admin?
        cannot :manage, :all
      else
        can :read, Subject
        can [:read, :create], Exam
      end
    end
  end
end
