class PostsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  def index
    @posts = Post.all
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
      render :new, danger: t('posts.failed_create')
    end
  end

  def edit; end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, success: t('posts.success_update')
    else
      render :edit, danger: t('posts.failed_update')
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, success: t('posts.success_delete')
    else
      flash[:danger] = t('posts.failed_delete')
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :summary, :body, :level)
  end
end
