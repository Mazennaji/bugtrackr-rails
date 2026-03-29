class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authenticate_user!

  private

  def authenticate_user!
    header = request.headers["Authorization"]
    raise ExceptionHandler::MissingToken, "Missing token" unless header

    token = header.split(" ").last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id])
  end

  def current_user
    @current_user
  end
end