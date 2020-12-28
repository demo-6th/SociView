class CreatePostCleans < ActiveRecord::Migration[6.0]
  def change
    create_table :post_cleans do |t|
      t.integer :post_id
      t.text :clean_text
      t.integer :post_clean

      t.timestamps
    end
  end
end
