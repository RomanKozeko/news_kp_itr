class PostsController < ApplicationController

  def index
    @posts = Post.includes(:tags, :category).paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.includes(:tags, :category).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, success: "Новость успешно создалась"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post , success: "Новость успешно обновлена"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, danger: "Новость удалена"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body, :all_tags, :category_id)
  end


end
