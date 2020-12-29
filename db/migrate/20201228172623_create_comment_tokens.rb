class CreateCommentTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_tokens do |t|
      t.integer :comment_token
      t.text :token
      t.integer :comment_id
      t.text :stop_words

      t.timestamps
    end
  end
end
