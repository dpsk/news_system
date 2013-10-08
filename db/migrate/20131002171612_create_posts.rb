class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.boolean :published, :default => false
      t.string  :link
      t.text    :body
      t.timestamps
    end

    add_index :posts, :published
    add_index :posts, :link
  end
end
