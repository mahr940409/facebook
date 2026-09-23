
class UserFriendMapper
  attr_accessor :current_user, :visiting_user

  def initialize(current_user, visiting_user)
    @current_user = current_user
    @visiting_user = visiting_user
  end

  def friends
    friends_user1 = Friend.includes(:sent, :request).where("(request_id = :id OR sent_id = :id) AND status = :status", id: current_user.id, status: :friends)
    friends_user2 = Friend.includes(:sent, :request).where("(request_id = :id OR sent_id = :id) AND status = :status AND request_id != :current_user_id AND sent_id != :current_user_id", id: visiting_user.id, status: :friends, current_user_id: current_user.id)


    frineds_user1 = map_other_user_from_friend_collection(friends_user1, current_user)
    frineds_user2 = map_other_user_from_friend_collection(friends_user2, visiting_user)

    frineds_user2.map do |user_friend_object|
      user_friend_object.mutual =
        frineds_user1.map(&:other_user).include?(user_friend_object.other_user)

        user_friend_object
    end
  end


  def map_other_user_from_friend_collection(friends, user)
    new_hash = friends.clone
    new_hash.map do |friend|
      UserFriendObject.new(friend, user)
    end
  end
end

class UserFriendObject
  attr_accessor :status, :friend_obj_id, :user_id,
                :other_user, :mutual, :avatar

  def initialize(friend_obj, user)
    @status = friend_obj.status
    @friend_obj_id = friend_obj.id
    @user_id = user.id
    @other_user = Friend.show_other_user(friend_obj, user)
    @mutual = false
    @avatar = @other_user.avatar
  end
end
