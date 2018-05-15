class UsersController < ApplicationController
  def show_all
    @users = User.all
  end

  def show_profile
    @user = User.find(params[:id])
  end

  def update_profile
    @user = User.find(params[:id])
    #@user.avatar = params[:avatar]
    if @user.update(name: params[:name], avatar: params[:avatar])
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
