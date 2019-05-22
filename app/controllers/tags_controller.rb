class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:id])
    @pagy, @posts = pagy(@tag.posts, items: PostsController::PAGY_POSTS_ITEMS)
  end
end
