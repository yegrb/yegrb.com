# typed: true
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new
    can :read, Event
    can :read, Opportunity
    can :read, Video
    can :signup, User
    can :use, Invite

    if user.user?
      can :read, User, id: user.id
      can :edit, User, id: user.id
      can :manage, Opportunity, user_id: user.id
      # cannot manage events
      # can :manage, Event, user_id: user.id
    end

    if user.editor?
      can :manage, Event
      can :manage, Video
      can :manage, Opportunity
      can :read, User
      can :read_all, User
      can :manage, Invite
    end

    # admins have god access MUAHAHA!

    can :manage, :all if user.admin?
  end
end
