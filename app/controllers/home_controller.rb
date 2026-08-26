class HomeController < ApplicationController
  def index
    @friendships = Friend.where(user: current_user)
                         .or(Friend.where(friend: current_user))

    @post = Post.new
    friends = Friend.where(status: "friends")
                .where(sent_id: current_user.id)
                .or(
                  Friend.where(status: "friends", request_id: current_user.id)
                )

    friend_ids = friends.map do |friend|
      if friend.sent_id == current_user.id
        friend.request_id
      else
        friend.sent_id
      end
    end

    other_posts = Post.where(user_id: friend_ids)
    @posts = (current_user.posts + other_posts).sort_by(&:created_at)
  end
end
