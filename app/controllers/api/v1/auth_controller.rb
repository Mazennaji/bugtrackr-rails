class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:register, :login]

  def register
    user = User.create!(user_params)
    token = JsonWebToken.encode(user_id: user.id)
    render json: { token: token, user: user_response(user) }, status: :created
  end

  def login
    user = User.find_by!(email: params[:email].downcase)
    raise ExceptionHandler::AuthenticationError, "Invalid credentials" unless user.authenticate(params[:password])

    token = JsonWebToken.encode(user_id: user.id)
    render json: { token: token, user: user_response(user) }
  end

  def refresh
    token = JsonWebToken.encode(user_id: current_user.id)
    render json: { token: token }
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def user_response(user)
    { id: user.id, name: user.name, email: user.email }
  end
end