class CreateCommentTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_tokens do |t|
      t.text :token
      t.string :cid
      t.text :no_stop_words

      t.timestamps
    end
  end
end
