class GroupchatsController < ApplicationController
  def index
    @groupchats = Groupchat.where(sender_id: current_user.id)
                         .or(Groupchat.where(reciver_id: current_user.id))

    @friends = Friend.includes(:sent, :request)
                     .where("request_id = :id OR sent_id = :id",
                            id: current_user.id
                          )
                          .where(status: "friends")
  end

  def show
    @groupchat = Groupchat.find(params[:id])
    @sender = @groupchat.other_user(current_user)
    @messages = @groupchat.messages
    @message = Message.new
  end


  def create
    find_groupchat = Groupchat.where(sender_id: params[:sender], reciver_id: params[:reciver])
                         .or(Groupchat.where(sender_id: params[:reciver], reciver_id: params[:sender])).first
    if find_groupchat.present?
      groupchat = Groupchat.find(find_groupchat.id)
    else
      groupchat = Groupchat.create(sender_id: params[:sender], reciver_id: params[:reciver])
    end
    groupchat.messages.create(text: params[:text], user_id: params[:sender])
    redirect_to groupchat_path(groupchat)
  end

  def new
    @groupchat = Groupchat.new
    @sender = User.find(params[:sender])
    @reciver = User.find(params[:reciver])
  end
end
