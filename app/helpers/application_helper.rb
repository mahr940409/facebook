module ApplicationHelper
  def display_corrent_user_name(friend_obj, current_user)
    Friend.show_other_user(friend_obj, current_user)
  end
end
