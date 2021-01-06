class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, id: :string do |t|
      t.integer :post_id
      t.text :content
      t.integer :like_count
      t.string :alias
      t.string :url

      t.timestamps
    end
  end
end
