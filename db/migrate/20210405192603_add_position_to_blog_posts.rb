class AddPositionToBlogPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :blog_posts, :position, :integer
  end
end
