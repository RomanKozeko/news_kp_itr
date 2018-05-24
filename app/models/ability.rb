class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new # guest user (not logged in)
      if user.role == "admin"
        can :manage, :all
      end
      if user.role == "author"
        can :index, Post
        can :show, Post
        can :show, Category
        can :show_all, User
        can :show_profile, User
        can :update_profile, User do |u|
          u == user
        end
        can :index, Post
        can :create, Post
        can :update, Post do |post|
          post.user == user
        end
        can :destroy, Post do |post|
          post.user == user
        end
      end
      if user.role == "user"
        can :index, Post
        can :show, Post
        can :show, Category
        can :show_all, User
        can :show_profile, User
        can :update_profile, User do |u|
          u == user
        end
      end
      if user.role == nil
        can :index, Post
        can :show, Post
        can :show, Category
        can :show_all, User
        can :show_profile, User
      end


  end
end
