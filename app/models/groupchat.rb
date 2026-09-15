class Groupchat < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :reciver, class_name: "User", foreign_key: :reciver_id
  has_many :messages


  def other_user(current_user)
    if current_user.id == sender_id
      reciver
    else
      sender
    end
  end
end
