module ExceptionHandler
  extend ActiveSupport::Concern

  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end
  class AuthenticationError < StandardError; end

  included do
    rescue_from ExceptionHandler::InvalidToken, with: :unauthorized
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable

    private

    def unauthorized(e)
      render json: { error: e.message }, status: :unauthorized
    end

    def not_found(e)
      render json: { error: e.message }, status: :not_found
    end

    def unprocessable(e)
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end