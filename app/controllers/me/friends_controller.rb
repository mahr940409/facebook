class Me::FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
    friends = Friend.includes(:sent, :request).where("request_id = :id OR sent_id = :id", id: current_user.id)

    search(params[:query])
    @friends_status_requested = friends.where(status: "requested")
    @friends = friends.where(status: "friends")
  end

  def search(query)
    if query.present?
      query = query.strip
      @users = User.where("email LIKE :query", query: "%#{query}%")
                    .where.not(id: @user.id)
    else
      @users = User.none
    end
  end
end
