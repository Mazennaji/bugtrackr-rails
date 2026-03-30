require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do
  path '/api/v1/auth/register' do
    post 'Register a new user' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      security []

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name:                  { type: :string, example: 'John Doe' },
          email:                 { type: :string, example: 'john@example.com' },
          password:              { type: :string, example: '123456' },
          password_confirmation: { type: :string, example: '123456' }
        },
        required: %w[name email password password_confirmation]
      }

      response '201', 'user registered' do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id:    { type: :integer },
                name:  { type: :string },
                email: { type: :string }
              }
            }
          }
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/v1/auth/login' do
    post 'Login user' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      security []

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email:    { type: :string, example: 'john@example.com' },
          password: { type: :string, example: '123456' }
        },
        required: %w[email password]
      }

      response '200', 'login successful' do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id:    { type: :integer },
                name:  { type: :string },
                email: { type: :string }
              }
            }
          }
        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end