class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :board_number
      t.integer :board_id
      t.integer :post_number
      t.string :url
      t.string :title
      t.string :author
      t.text :content
      t.integer :comment_count
      t.integer :like_count

      t.timestamps
    end
  end
end
