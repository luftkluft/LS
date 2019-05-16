class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:id])
    # @posts = @tag.posts
    @pagy, @posts = pagy(@tag.posts, items: 3)
  end
end
