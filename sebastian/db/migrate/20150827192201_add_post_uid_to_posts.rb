class AddPostUidToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_uid, :integer
    add_index :posts, :post_uid, unique: true
    remove_index :posts, :slug
    add_index :posts, :slug
  end
end
