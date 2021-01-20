class Comment < ApplicationRecord
  belongs_to :post, foreign_key: "pid", primary_key: "pid"
end
