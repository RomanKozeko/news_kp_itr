class AuthorsController < ApplicationController
  def index
    @authors = User.all
  end

  def show
    @author = User.find(params[:id])
  end

  def edit
    @author = User.find(params[:id])
  end

  def update
    @author = User.find(params[:id])
    if @author.update(author_params)
      redirect_to @author , success: "Профиль успешно обновлен"
    else
      render :show
    end
  end

  private

  def author_params
    params.require(:user).permit(:name, :avatar)
  end
end
