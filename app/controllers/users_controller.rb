class UsersController < ApplicationController
  def show_all
    @users = User.all
    authorize! :show_all, User
  end

  def show_profile
    @user = User.find(params[:id])
    @posts = @user.posts.order(:updated_at).reverse_order
    authorize! :show_profile, @user
  end

  def update_profile

    @user = User.find(params[:id])
    authorize! :update_profile, @user
    if @user.update_attributes(name: params[:name], avatar: params[:avatar])
      redirect_to :show_profile , success: "Профиль успешно обновлен"
    else
      render :show_profile
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
