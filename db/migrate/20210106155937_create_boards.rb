class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :alias
      t.integer :source_id

      t.timestamps
    end
  end
end
