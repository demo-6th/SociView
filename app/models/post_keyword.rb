class PostKeyword < ApplicationRecord
  belongs_to :post, class_name: "Post", foreign_key: "pid", primary_key: "pid"
end
