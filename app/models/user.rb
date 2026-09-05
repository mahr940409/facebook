class User < ApplicationRecord
  has_many :friends
  has_many :likes
  has_many :comments
  has_many :posts
  has_one_attached :avatar
  attr_accessor :remove_avatar
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

  def update_password(params, current_user)
    me = current_user
    if params[:user][:current_password] != nil
      if params[:user][:password] != nil
        if params[:user][:password_confirmation] != nil
          me.update_with_password({
            current_password: params[:user][:current_password],
            password: params[:user][:password],
            password_confirmation: params[:user][:password_confirmation]
          })
        end
      end
    end
  end

  before_save :purge_avatar_if_requested

  private

  def purge_avatar_if_requested
    if remove_avatar == "1"
      avatar.purge_later
    end
  end
end
