class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :pid
      t.text :post_content
      t.string :title
      t.integer :comment_count
      t.integer :like_count
      t.string :alias
      t.string :url
      t.string :author
      t.timestamps
    end
  end
end
