class CreateCommentKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_keywords do |t|

      t.timestamps
    end
  end
end
