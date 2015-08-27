class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :slug
      t.datetime :posted_at
      t.datetime :fetched_at, default: '0000-00-00 00:00:00'
      t.datetime :orig_html, default: ''
      t.datetime :cleaned_html, default: ''

      t.timestamps null: false
    end
    add_index :posts, :slug, unique: true
    add_index :posts, :posted_at
  end
end
