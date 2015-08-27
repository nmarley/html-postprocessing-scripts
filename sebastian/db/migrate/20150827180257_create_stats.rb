class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :last_archive_page_fetched, default: 0
    end
  end
end
