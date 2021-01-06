class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.text :content
      t.string :type
      t.integer :post_id
      t.string :comment_id
      t.timestamps
    end
  end
end
