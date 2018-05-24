class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    authorize! :index, Category
  end

  def show
    @category = Category.find(params[:id])
    @posts = Post.includes(:tags, :category, :user).where(category_id: [@category.subtree_ids]).paginate(page: params[:page], per_page: 10)
    authorize! :show, @category
  end

  def new
    @category = Category.new
    authorize! :create, @category
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, success: "Категория успешно создана"
    else
      render :new
    end
    authorize! :create, @category
  end

  def edit
    @category = Category.find(params[:id])
    authorize! :update, @category
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, success: "Категория изменена"
    else
      render :edit
    end
    authorize! :update, @category
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
    authorize! :destroy, @category
  end
end

private

def category_params
  params.require(:category).permit(:name, :parent_id)
end
