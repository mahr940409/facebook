class MessagesController < ApplicationController
  def index
    @messages = Menssage.all
  end

  def create
    groupchat = Groupchat.find(params[:groupchat_id])
    groupchat.messages.create(text: params[:text], user_id: current_user.id)
    redirect_to groupchat_path(groupchat)
  end

  def new
    @message = Menssage.new
  end
end
