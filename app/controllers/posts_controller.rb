class PostsController < ApplicationController
  load_and_authorize_resource except: %i[index show]

  def index
    @user = User.find_by(id: params[:user_id])
    @posts = Post.includes(:author).where(author_id: params[:user_id])
  end

  def show
    @post = Post.includes(:author).find_by(author_id: params[:user_id], id: params[:id])
    @user = @post.author
    @comments = Post.find(@post.id).comments
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.author_id = @user.id

    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post created successfully!'
    else
      redirect_to user_posts_path(@user), alert: 'Failed to create the post.'
    end
  end

  def destroy
    @user = current_user
    @post = @user.posts.find_by(id: params[:id])

    puts @post.inspect
    if @post.destroy
      redirect_to user_posts_path(@user), notice: 'Post deleted successfully!'
    else
      redirect_to user_posts_path(@user), alert: 'Failed to delete the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
