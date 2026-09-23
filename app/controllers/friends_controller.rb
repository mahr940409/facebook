class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    friends = Friend.includes(:sent, :request).where("request_id = :id OR sent_id = :id", id: @user.id)

    search(params[:query])
    @friends_status_requested = friends.where(status: "requested")
    @friends = UserFriendMapper.new(current_user, @user).friends
  end

  def create
    friend = User.find(params[:id])
    f = current_user.add_friend(friend)
    if f.save
      redirect_to friends_path, notice: "Solicitud envida con Exito"
    else
      redirect_to friends_path, alert: "No se pudo enviar la solicitud de amistad"
    end
  end

  def update
    obj_friend = Friend.find_by(sent_id: (params[:id]), request_id: current_user, status: "requested")
    current_user.accept_request(obj_friend)
    redirect_to friends_path
  end

  def destroy
    if params[:friend_obj_id].present?
      Friend.find(params[:friend_obj_id]).destroy
    else
      obj_friend = Friend.find_by(sent_id: (params[:id]), request_id: current_user.id, status: "requested")
      current_user.not_accept_request(obj_friend)
    end
    redirect_to friends_path
  end

  def show
    @user = User.find(params[:id])
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
