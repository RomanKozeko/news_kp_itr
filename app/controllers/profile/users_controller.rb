class Profile::UsersController < ApplicationController

  def index
    @users = User.all.paginate(page: params[:page], per_page: 30)
    authorize! :index, User
  end

  def edit
    @user = User.find_by_id(params[:id])
    authorize! :edit, @user
    if @user
    @posts = @user.posts.order(:updated_at).reverse_order.paginate(page: params[:page], per_page: 15)
    else
      redirect_to profile_users_path, danger: "#{t(".not_found")}"
    end

  end

  def update
    @user = User.find_by_id(params[:id])
    authorize! :update, @user
    if @user
      @user.update(user_params)
      redirect_to edit_profile_user_path(@user) , success: "Профиль успешно обновлен"
    else
      @posts = @user.posts.order(:updated_at).reverse_order.paginate(page: params[:page], per_page: 15)
      render :edit
    end
  end

  def update_role
    authorize! :update_role, @user
    if @user = User.find_by_id(params[:id])
      @user.update(user_role_params)
      redirect_to edit_profile_user_path(@user) , success: "Роль успешно обновлена"
    else
      @posts = @user.posts.order(:updated_at).reverse_order.paginate(page: params[:page], per_page: 15)
      render :edit
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :locale)
  end

  def user_role_params
    params.require(:user).permit(:role)
  end

end
