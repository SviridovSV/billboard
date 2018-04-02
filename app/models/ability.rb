class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    return unless user.present?
    if user.admin?
      can :manage, :all
      cannot :destroy, User, role: 1
    end
    if user.moderator?
      can :manage, Post
      can :manage, Comment
    end
    can :manage, Post, user_id: user.id
    can :manage, Comment, user_id: user.id
  end
end
