class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  def index
    @pagy, @posts = pagy(Post.all, items: 2)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, success: t('posts.success_create')
    else
      flash.now[:danger] = t('posts.failed_create')
      render :new
    end
  end

  def edit; end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, success: t('posts.success_update')
    else
      flash.now[:danger] = t('posts.failed_update')
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, success: t('posts.success_delete')
    else
      flash.now[:danger] = t('posts.failed_delete')
      redirect_to posts_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :summary, :body, :level, :image, :all_tags)
  end
end
