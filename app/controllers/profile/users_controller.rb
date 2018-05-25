class Profile::UsersController < ApplicationController

  def index
    @users = User.all
    authorize! :index, User
  end

  def edit
    @user = User.find(params[:id])
    @posts = @user.posts.order(:updated_at).reverse_order
    authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update(user_params)
    #if @user.update_attributes(name: params[:name], avatar: params[:avatar])
      redirect_to edit_profile_user_path(@user) , success: "Профиль успешно обновлен"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
