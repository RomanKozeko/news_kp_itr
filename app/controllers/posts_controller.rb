class PostsController < ApplicationController

  def index
    @posts = Post.includes(:tags, :category, :user).order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    authorize! :index, Post
  end

  def show
    @post = Post.includes(:tags, :category, :user).find(params[:id])
    @new_comment = Comment.build_from(@post, current_user.id, "") if user_signed_in?
    respond_to do |format|
      format.html
      format.pdf {render template: "posts/show", pdf: "show"}
    end
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
    authorize! :create, @post
    if @post.save
      redirect_to @post, success:  "#{t(".success_create")}"
    else
      render :new
    end
  end

  def edit
    unless @post = Post.find_by_id(params[:id])
      @post = Post.new
    end
    authorize! :update, @post
  end

  def update
    @post = Post.find_by_id(params[:id])
    authorize! :update, @post
    if @post
      @post.update(post_params)
      redirect_to @post , success:  "#{t(".success_update")}"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    if @post.destroy
      redirect_to posts_path, success:  "#{t(".success_destroy")}"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body, :all_tags, :category_id, :user_id, :preview)
  end


end
