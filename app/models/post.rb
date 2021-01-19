class Post < ApplicationRecord
  belongs_to :board, foreign_key: "alias", primary_key: "alias"
  has_many :comments, foreign_key: "pid", primary_key: "pid"
  searchkick language: "chinese"
  scope :search_import, -> { includes(:board, :comments) }
  def search_data
    {
       title: title,
       content: content,
       created_at: created_at,
       board_name: board.name,
       comment_content: comments.map(&:content)
    }
  end
end

