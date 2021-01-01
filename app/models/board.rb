class Board < ApplicationRecord
  belongs_to :source
  has_many :posts, class_name: "Post", foreign_key: "alias", primary_key: "alias"
end
