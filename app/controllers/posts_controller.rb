class PostsController < ApplicationController
  def create
    current_user.posts.create(text: params[:post][:text])
    redirect_to root_path
  end

  def index
    @post = Post.find(params[:post_id])
  end


  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @count = @post.likes.count
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:post_id])
    post.text = (params[:text])
    post.save
    redirect_to post_path(post)
  end
end
