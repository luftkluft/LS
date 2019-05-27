class CategoriesController < ApplicationController
  PAGY_CATEGORIES_ITEMS = 5
  DEFAULT_PAGE_NUMBER = 0
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  def index
    authorize Category
    @current_page = current_page
    @pagy, @categories = pagy(Category.all.order(:name), items: PAGY_CATEGORIES_ITEMS)
  end

  def show
    crypter = CryptPostService.new
    decrypted_posts = crypter.decypted_posts(Post.where(category_id: [@category.subtree_ids]))
    posts = pagy(decrypted_posts, items: PAGY_CATEGORIES_ITEMS)
    posts[1] = decrypted_posts # <= fix pagy
    flash.now[:danger] = crypter.errors.first if crypter.errors.any?
    @pagy, @posts = posts
  end

  def new
    @category = Category.new
    authorize @category
    @categories = Category.all.order(:name)
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      redirect_to categories_path, success: t('categories.success_create')
    else
      @categories = Category.all.order(:name)
      flash[:danger] = t('categories.failed_create')
      render :new
    end
  end

  def edit
    authorize @category
    @categories = Category.where("id != #{@category.id}").order(:name)
  end

  def update
    authorize @category
    if @category.update_attributes(category_params)
      redirect_to categories_path, success: t('categories.success_update')
    else
      @categories = Category.where("id != #{@category.id}").order(:name)
      flash[:danger] = t('categories.failed_update')
      render :edit
    end
  end

  def destroy
    authorize @category
    if @category.destroy
      redirect_to categories_path, success: t('categories.success_delete')
    else
      flash.now[:danger] = t('categories.failed_delete')
      redirect_to categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue StandardError
    redirect_to categories_path
  end

  def current_page
    params.permit(:page)[:page].to_i
  rescue StandardError
    DEFAULT_PAGE_NUMBER
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
