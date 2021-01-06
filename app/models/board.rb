class Board < ApplicationRecord
  belongs_to :source
  has_many :posts, foreign_key: "alias", primary_key: "alias"
end
