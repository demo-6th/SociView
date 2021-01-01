class CreatePostTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tokens do |t|
      t.text :token
      t.integer :pid
      t.text :no_stop_words

      t.timestamps
    end
  end
end
