class CreateArchivePages < ActiveRecord::Migration
  def change
    create_table :archive_pages do |t|
      t.integer :number
      t.datetime :fetched_at, default: nil
      t.text :orig_html, default: ''
      t.boolean :indexed_entries, default: false

      t.timestamps null: false
    end
    add_index :archive_pages, :number
  end
end
