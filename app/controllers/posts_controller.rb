class PostsController < ApplicationController
  def create
    post = current_user.posts.new(text: params[:post][:text], image: params[:post][:image])
    if post.save
      redirect_to root_path, notice: "Post agregado correctamente"
    else
      redirect_to root_path, alert: "Post no agregado correctamente"
    end
  end

  def index
    @post = Post.find(params[:post_id])
  end


  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
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
    post = Post.find(params[:id])
    post.text = (params[:post][:text])
    if params[:post][:image].present?
      post.image = (params[:post][:image])
    end
    if params[:post][:remove_image].present?
      post.remove_image = params[:post][:remove_image]
    end
    post.save
    redirect_to post_path(post)
  end
end
