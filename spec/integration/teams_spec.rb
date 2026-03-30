require 'swagger_helper'

RSpec.describe 'Teams API', type: :request do
  path '/api/v1/teams' do
    get 'List all teams' do
      tags 'Teams'
      produces 'application/json'
      security [{ bearerAuth: [] }]

      response '200', 'teams listed' do
        run_test!
      end
    end

    post 'Create a team' do
      tags 'Teams'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [] }]

      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'My Team' }
        },
        required: %w[name]
      }

      response '201', 'team created' do
        run_test!
      end
    end
  end

  path '/api/v1/teams/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get a team' do
      tags 'Teams'
      produces 'application/json'
      security [{ bearerAuth: [] }]

      response '200', 'team found' do
        run_test!
      end
    end

    patch 'Update a team' do
      tags 'Teams'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [] }]

      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        }
      }

      response '200', 'team updated' do
        run_test!
      end
    end

    delete 'Delete a team' do
      tags 'Teams'
      security [{ bearerAuth: [] }]

      response '200', 'team deleted' do
        run_test!
      end
    end
  end
end