class Message < ApplicationRecord
  belongs_to :groupchat
  belongs_to :user

  validates :text, presence: true
end
