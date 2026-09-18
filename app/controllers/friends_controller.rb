class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
    friends = Friend.includes(:sent, :request).where("request_id = :id OR sent_id = :id", id: @user.id)

    search(params[:query])

    friends_status_friends = friends.where(status: "friends")
    @friends_status_requested = friends.where(status: "requested")


    @requests = User.map_other_user_from_friend_collection(@friends_status_requested, @user)

    if params[:user_id].present?
      @comun_friends = User.mutual_friends(current_user, User.find(params[:user_id]))
    else
      @comun_friends = User.map_other_user_from_friend_collection(friends_status_friends, @user)
    end

    #--
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
    obj_friend = Friend.find_by(sent_id: (params[:id]), request_id: current_user.id, status: "requested")
    current_user.accept_request(obj_friend)
    redirect_to friends_path
  end

  def destroy
    obj_friend = Friend.find_by(sent_id: (params[:id]), request_id: current_user.id, status: "requested")
    current_user.not_accept_request(obj_friend)
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
