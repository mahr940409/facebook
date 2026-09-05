class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  attr_accessor :remove_image

  validates :text, presence: true

  before_save :purge_image_if_requested

  private

  def purge_image_if_requested
    if remove_image == "1"
      image.purge_later
    end
  end
end
