class CreateCommentTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_tokens do |t|

      t.timestamps
    end
  end
end
