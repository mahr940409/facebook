class Friend < ApplicationRecord
  belongs_to :request, class_name: "User", foreign_key: :request_id
  belongs_to :sent, class_name: "User", foreign_key: :sent_id

  def self.show_other_user(friend_obj, current_user)
    if current_user.id == friend_obj.request_id
      friend_obj.sent
    else
      friend_obj.request
    end
  end
end
