class PostsController < ApplicationController
  PAGY_POSTS_ITEMS = 3
  before_action :authenticate_user!
  before_action :set_encrypted_post, only: %i[update]
  before_action :set_decrypted_post, only: %i[show edit]
  before_action :set_post, only: %i[destroy]
  
  def index
    crypter = CryptPostService.new
    decrypted_posts = crypter.decypted_posts(Post.user_level_posts(current_user))
    posts = pagy(decrypted_posts, items: PAGY_POSTS_ITEMS)
    posts[1] = decrypted_posts # <= fix pagy
    flash.now[:danger] = crypter.errors.first if crypter.errors.any?
    @pagy, @posts = posts
  end

  def show; end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    crypter = CryptPostService.new
    @post = Post.new(crypter.encrypted_data(post_params))
    authorize @post
    if @post.save
      redirect_to @post, success: t('posts.success_create')
    else
      flash.now[:danger] = t('posts.failed_create')
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    crypter = CryptPostService.new
    if @post.update_attributes(crypter.encrypted_data(post_params))
      redirect_to @post, success: t('posts.success_update')
    else
      flash.now[:danger] = t('posts.failed_update')
      render :edit
    end
  end

  def destroy
    authorize @post
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

  def set_encrypted_post
    crypter = CryptPostService.new
    @post = Post.find(params[:id])
    @post = crypter.encrypted_data(@post)
    flash.now[:danger] = crypter.errors.first if crypter.errors.any?
    @post
  end

  def set_decrypted_post
    crypter = CryptPostService.new
    @post = Post.find(params[:id])
    @post = crypter.decrypted_back(@post)
    flash.now[:danger] = crypter.errors.first if crypter.errors.any?
    @post
  end

  def post_params
    params.require(:post).permit(:title, :summary, :body, :level, :image, :all_tags, :category_id)
  end
end
