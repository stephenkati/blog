class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def index
    users = User.all

    if users
      render json: { status: 'Success', message: 'Users fetched successfully', data: users }, status: :ok
    else
      render json: { status: 'Error', message: 'Failed to fetch users', errors: users.errors }, status: :bad_request
    end
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      render json: { status: 'Success', message: 'User fetched successfully', data: user }, status: :ok
    else
      render json: { status: 'Error', message: 'Failed to fetch user', errors: user.errors }, status: :bad_request
    end
  end
end
