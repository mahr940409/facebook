class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @like = Like.new(user_id: current_user.id, post_id: post.id)
    @like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to post_path(post)
  end

  def new
    @like = Like.new
  end
end
