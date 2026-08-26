class Comment < ApplicationRecord
  belongs_to :user
  has_many :like
  belongs_to :post
end
