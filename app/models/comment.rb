class Comment < ApplicationRecord
  belongs_to :post, foreign_key: "pid", primary_key: "pid"
  searchkick callbacks: :async
  scope :search_import, -> { includes(:post) }
  def search_data
    {
       content: content,
       created_at: created_at,
       post: post
    }
  end
end
