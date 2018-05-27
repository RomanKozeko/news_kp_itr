class Profile::UsersController < ApplicationController

  def index
    @users = User.all.paginate(page: params[:page], per_page: 30)
    authorize! :index, User
  end

  def edit
    @user = User.find(params[:id])
    @posts = @user.posts.order(:updated_at).reverse_order.paginate(page: params[:page], per_page: 15)
    authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
    @posts = @user.posts.order(:updated_at).reverse_order
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to edit_profile_user_path(@user) , success: "Профиль успешно обновлен"
    else
      render :edit
    end
  end

  def update_role
    @user = User.find(params[:id])
    @posts = @user.posts.order(:updated_at).reverse_order
    authorize! :update_role, @user
    if @user.update(user_role_params)
      redirect_to edit_profile_user_path(@user) , success: "Профиль успешно обновлен"
    else
      render :edit
      end

  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  def user_role_params
    params.require(:user).permit(:role)
  end

end
