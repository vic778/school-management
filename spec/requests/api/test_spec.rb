require 'swagger_helper'

RSpec.xdescribe 'api/test', type: :request do
  path '/api/tests' do
    get 'Tests' do
      tags 'Tests'
      consumes 'application/json'
      security [bearer_auth: []]
      response '200', 'test' do
        run_test!
      end
    end
  end

  path '/api/tests/{id}' do
    get 'Tests' do
      tags 'Tests'
      consumes 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :string
      response '200', 'test' do
        run_test!
      end
    end
  end

  path '/api/tests' do
    post 'Creates a test' do
      tags 'Tests'
      consumes 'application/json'
      security [bearer_auth: []]
      parameter name: :test, in: :body, schema: {
        type: :object,
        properties: {
          test: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string }
            },
            required: %w[name description]
          }
        },
        required: ['test']
      }

      response '200', 'test created' do
        let(:test) { { test: { name: 'bar', description: 'bar' } } }
      end

      response '422', 'invalid request' do
        let(:test) { { test: { name: 'foo' } } }
        run_test!
      end
    end
  end

  path '/api/tests/{id}' do
    put 'Updates a test' do
      tags 'Tests'
      consumes 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :string
      parameter name: :test, in: :body, schema: {
        type: :object,
        properties: {
          test: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string }
            },
            required: %w[name description]
          }
        },
        required: ['test']
      }

      response '200', 'test updated' do
        let(:test) { { test: { name: 'bar', description: 'bar' } } }
      end

      response '422', 'invalid request' do
        let(:test) { { test: { name: 'foo' } } }
        run_test!
      end
    end
  end

  path '/api/tests/{id}' do
    delete 'Deletes a test' do
      tags 'Tests'
      consumes 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'test deleted' do
        run_test!
      end
    end
  end
end
