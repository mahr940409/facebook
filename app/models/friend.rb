class Friend < ApplicationRecord
  belongs_to :request, class_name: "User", foreign_key: :request_id
  belongs_to :sent, class_name: "User", foreign_key: :sent_id
  validate :unique_interchangeable_pair

  def self.show_other_user(friend_obj, current_user)
    if current_user.id == friend_obj.request_id
      friend_obj.sent
    else
      friend_obj.request
    end
  end

  def unique_interchangeable_pair
    exists = Friend.where(sent_id: sent_id, request_id: request_id)
                      .or(Friend.where(sent_id: request_id, request_id: sent_id))

    exists = exists.where.not(id: id) if persisted?

    if exists.exists?
      errors.add(:base, "Ya existe una solicitud o amistad entre estos dos usuarios.")
    end
  end
end
