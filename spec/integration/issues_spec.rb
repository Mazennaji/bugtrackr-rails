require 'swagger_helper'

RSpec.describe 'Issues API', type: :request do
  path '/api/v1/teams/{team_id}/projects/{project_id}/issues' do
    parameter name: :team_id,    in: :path, type: :integer
    parameter name: :project_id, in: :path, type: :integer

    get 'List all issues' do
      tags 'Issues'
      produces 'application/json'
      security [{ bearerAuth: [] }]

      parameter name: 'q[title_cont]',    in: :query, type: :string, required: false, description: 'Search by title'
      parameter name: 'q[priority_eq]',   in: :query, type: :string, required: false, description: 'Filter by priority'
      parameter name: 'q[assignee_id_eq]',in: :query, type: :integer, required: false, description: 'Filter by assignee'

      response '200', 'issues listed' do
        run_test!
      end
    end

    post 'Create an issue' do
      tags 'Issues'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [] }]

      parameter name: :issue, in: :body, schema: {
        type: :object,
        properties: {
          title:       { type: :string, example: 'Fix login bug' },
          description: { type: :string, example: 'JWT token not refreshing' },
          priority:    { type: :string, enum: %w[low medium high critical] },
          due_date:    { type: :string, format: 'date-time' },
          assignee_id: { type: :integer },
          column_id:   { type: :integer }
        },
        required: %w[title column_id]
      }

      response '201', 'issue created' do
        run_test!
      end
    end
  end

  path '/api/v1/teams/{team_id}/projects/{project_id}/issues/{id}/move' do
    parameter name: :team_id,    in: :path, type: :integer
    parameter name: :project_id, in: :path, type: :integer
    parameter name: :id,         in: :path, type: :integer

    patch 'Move issue to another column' do
      tags 'Issues'
      consumes 'application/json'
      produces 'application/json'
      security [{ bearerAuth: [] }]

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          column_id: { type: :integer, example: 2 }
        },
        required: %w[column_id]
      }

      response '200', 'issue moved' do
        run_test!
      end
    end
  end
end