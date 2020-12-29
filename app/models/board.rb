class Board < ApplicationRecord
  belongs_to :source
  has_many :posts
end
