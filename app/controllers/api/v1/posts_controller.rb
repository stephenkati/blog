class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    @posts = Post.includes(:author).where(author_id: params[:user_id])
    @user = User.includes(:posts).find(params[:user_id])

    if @posts
      render json: { status: 'Success', message: 'Posts fetched successfully', data: @posts }, status: :ok
    else
      render json: { status: 'Error', message: 'Failed to fetch posts!', errors: @posts.errors }, status: :bad_request
    end
  end

  def show
    @post = Post.includes(:author).find_by(author_id: params[:user_id], id: params[:id])
    @user = @post.author

    if @post
      render json: { status: 'Success', message: 'Post fetched successfully', data: @post }, status: :ok
    else
      render json: { status: 'Error', message: 'Failed to fetch post!', errors: @post.errors }, status: :bad_request
    end
  end
end
