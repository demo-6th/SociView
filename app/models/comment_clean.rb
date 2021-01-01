class CommentClean < ApplicationRecord
  belongs_to :comment, class_name: "Comment", foreign_key: "cid", primary_key: "cid"
end
