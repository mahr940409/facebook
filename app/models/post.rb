class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :text, presence: true
end
