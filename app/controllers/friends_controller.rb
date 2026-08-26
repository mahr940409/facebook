class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = Friend.includes(:sent, :request)
                     .where("request_id = :id OR sent_id = :id",
                            id: current_user.id
                          )

    if params[:query].present?
      query = params[:query].strip
      @users = User.where("email LIKE :query", query: "%#{query}%")
                    .where.not(id: current_user.id)
    else
      @users = User.none
    end
  end

  def create
    friend = User.find(params[:id])
    current_user.add_friend(friend)
    redirect_to friends_path
  end

  def update
    friend = Friend.find(params[:id])
    current_user.acept_request(friend)
    redirect_to friends_path
  end

  def destroy
    friend = Friend.find(params[:id])
    current_user.not_acept_request(friend)
    redirect_to friends_path
  end
end
