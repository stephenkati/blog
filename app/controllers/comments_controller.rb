class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.author_id = @user.id

    puts @comment
    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment added Successfully'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to add comment!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
