class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    authorize! :index, Category
  end

  def show
    @category = Category.find(params[:id])
    authorize! :show, @category
    @posts = Post.includes(:tags, :category, :user).where(category_id: [@category.subtree_ids]).order(:created_at).reverse_order.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
    authorize! :create, @category
  end

  def create
    @category = Category.new(category_params)
    authorize! :create, @category
    if @category.save
      redirect_to categories_path, success: "#{t(".success_create")}"
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize! :update, @category
  end

  def update
    @category = Category.find(params[:id])
    authorize! :update, @category
    if @category.update(category_params)
      redirect_to categories_path, success: "#{t(".success_update")}"
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize! :destroy, @category
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

end