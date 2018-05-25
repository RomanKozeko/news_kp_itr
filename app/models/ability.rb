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
        can :index, User
        can :edit, User
        can :update, User do |u|
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
        can :index, User
        can :edit, User
        can :update, User do |u|
          u == user
        end
      end
      if user.role == nil
        can :index, Post
        can :show, Post
        can :show, Category
        can :index, User
        can :edit, User
      end


  end
end
