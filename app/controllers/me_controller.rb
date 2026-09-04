class MeController < ApplicationController
  def show
    @me = current_user
  end

  def edit
    @me = current_user
  end

  def update
    me = current_user
    if params[:user][:avatar].present?
      me.avatar = params[:user][:avatar]
    end
    if params[:user][:name].present? && params[:user][:lastname].present?
      me.name = params[:user][:name]
      me.lastname = params[:user][:lastname]
    else
      me.name = params[:user][:name]
      me.lastname = me.lastname || me.lastname = params[:user][:lastname]
      me.name = me.name
    end

    me.update_password(params, current_user)

    me.save
    redirect_to users_me_path
  end
end
