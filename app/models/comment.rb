class Comment < ApplicationRecord
  belongs_to :user
  has_many :like
  belongs_to :post

  validates :text, presence: true
end
