class User < ApplicationRecord
  has_many :friends
  has_many :likes
  has_many :comments
  has_many :posts
  has_many :messages
  has_many :groupchats
  has_one_attached :avatar
  attr_accessor :remove_avatar, :mutual

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :purge_avatar_if_requested

  def add_friend(friend)
    Friend.create(request_id: friend.id, sent_id: self.id)
  end

  def display_username
    self.name || self.email
  end

  def acept_request(friend)
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

  def send_message(reciver:, text:)
    groupchat = Groupchat.where(sender_id: self.id, reciver_id: reciver.id)
                            .or(Groupchat.where(sender_id: reciver.id, reciver_id: self.id))
    if groupchat.present?
      g_id = groupchat.first.id
      Message.create(user_id: self.id, text: text, groupchat_id: g_id)

    else
      new_groupchat = Groupchat.new(sender_id: self.id, reciver_id: reciver.id)
      new_groupchat.save
      new_groupchat.messages.create(user_id: self.id, text: text, groupchat_id: new_groupchat.id)
    end
  end

  private

  def purge_avatar_if_requested
    if remove_avatar == "1"
      avatar.purge_later
    end
  end
end
