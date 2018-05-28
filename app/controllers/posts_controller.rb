class PostsController < ApplicationController

  def index
    @posts = Post.includes(:tags, :category, :user).order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    authorize! :index, Post
  end

  def show
    @post = Post.includes(:tags, :category, :user).find(params[:id])
    @new_comment = Comment.build_from(@post, current_user.id, "") if user_signed_in?
  end

  def new
    if params[:user_id]
      @user = User.find(params[:user_id])
      @post = @user.posts.build
    else
      @post = current_user.posts.build
    end
    authorize! :create, @post
  end

  def create
    @user = User.find(post_params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to @post, success:  "#{t(".success_create")}"
    else
      render :new
    end
    authorize! :create, @post
  end

  def edit
    unless @post = Post.find_by_id(params[:id])
      @post = Post.new
    end
    authorize! :update, @post
  end

  def update

    if @post = Post.find_by_id(params[:id])
      @post.update(post_params)
      redirect_to @post , success:  "#{t(".success_update")}"
    else
      render :edit
    end
    authorize! :update, @post
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, success:  "#{t(".success_destroy")}"
    end
    authorize! :destroy, @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body, :all_tags, :category_id, :user_id, :preview)
  end


end
