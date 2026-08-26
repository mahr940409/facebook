class User < ApplicationRecord
  has_many :friends
  has_many :likes
  has_many :comments
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def add_friend(friend)
    Friend.create(request_id: friend.id, sent_id: self.id)
  end

  def acept_request(friend)
    # request = Friend.find_by(sent_id: friend.sent_id, request_id: friend.request_id)
    friend.status = "friends"
    friend.save
  end

  def not_acept_request(friend)
    friend.destroy
  end
end
