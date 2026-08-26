class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    current_user.comments.create(text: params[:text], post_id: params[:post_id])
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.text = (params[:text])
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    if comment.user_id == current_user.id
      comment.destroy
      redirect_to post_path(post)
    else
      redirect_to post_path(post)
    end
  end
end
