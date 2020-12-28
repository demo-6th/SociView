class CreateCommentKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_keywords do |t|
      t.text :keyword
      t.string :comment_id

      t.timestamps
    end
  end
end
