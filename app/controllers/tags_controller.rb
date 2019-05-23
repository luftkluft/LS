class TagsController < ApplicationController
  def show
    @pagy, @posts = decrypted_posts
  end

  private

  def decrypted_posts
    @tag = Tag.find_by(name: params[:id])
    crypter = CryptPostService.new
    decrypted_posts = crypter.decypted_posts(@tag.posts)
    posts = pagy(decrypted_posts, items: PostsController::PAGY_POSTS_ITEMS)
    posts[1] = decrypted_posts # <= fix pagy
    flash.now[:danger] = crypter.errors.first if crypter.errors.any?
    posts
  end
end
