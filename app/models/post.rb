class Post < ApplicationRecord
  belongs_to :board, foreign_key: "alias", primary_key: "alias"
  has_many :comments, foreign_key: "pid", primary_key: "pid"
end

