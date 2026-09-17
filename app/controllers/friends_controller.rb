class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
    friends = Friend.includes(:sent, :request).where("request_id = :id OR sent_id = :id", id: @user.id)

    search(params[:query])

    friends_status_friends = friends.where(status: "friends")
    @friends_status_requested = friends.where(status: "requested")
    @friends = map_other_user_from_friend_collection(friends_status_friends, @user)

    @requests = map_other_user_from_friend_collection(@friends_status_requested, @user)
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
    friend = Friend.find(params[:id])
    current_user.acept_request(friend)
    redirect_to friends_path
  end

  def destroy
    friend = Friend.find(params[:id])
    current_user.not_acept_request(friend)
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

  def map_other_user_from_friend_collection(friends, user)
    new_hash = friends.clone
    new_hash.map do |friend|
      if friend.sent_id == user.id
        friend.request
      else
        friend.sent
      end
    end
  end
end
