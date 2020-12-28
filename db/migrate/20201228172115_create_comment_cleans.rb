class CreateCommentCleans < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_cleans do |t|
      t.integer :comment_id
      t.text :clean_text
      t.integer :comment_clean

      t.timestamps
    end
  end
end
