class CreateCommentCleans < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_cleans do |t|
      t.string :cid
      t.text :clean_text

      t.timestamps
    end
  end
end
