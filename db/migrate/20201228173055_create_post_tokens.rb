class CreatePostTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tokens do |t|
      t.integer :post_token
      t.text :token
      t.integer :post_id
      t.text :stop_words

      t.timestamps
    end
  end
end
