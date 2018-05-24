class PostsController < ApplicationController

  def index
    @posts = Post.includes(:tags, :category, :user).order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    authorize! :index, Post
  end

  def show
    @post = Post.includes(:tags, :category, :user).find(params[:id])
    @new_comment = Comment.build_from(@post, current_user.id, "")
  end

  def new
    @post = Post.new
    authorize! :create, @post
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, success: "Новость успешно создалась"
    else
      render :new
    end
    authorize! :create, @post
  end

  def edit
    @post = Post.find(params[:id])
    authorize! :update, @post
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post , success: "Новость успешно обновлена"
    else
      render :edit
    end
    authorize! :update, @post
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, danger: "Новость удалена"
    end
    authorize! :destroy, @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body, :all_tags, :category_id, :user_id)
  end


end
