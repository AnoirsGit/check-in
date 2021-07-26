class Posts::BulkController < ApplicationController
  before_action :set_posts, only: %i(delete publish)

  def delete
    @posts.destroy_all
    redirect_to posts_path
  end

  def publish
    @posts.update_all(published: true)
    redirect_to posts_path,
                notice: 'Posts have been successfully updated'
  end

  private

  def set_posts
    @posts = params[:all] ? Post.all : Post.where(id: params[:ids])
  end
end
