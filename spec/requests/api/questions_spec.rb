require 'swagger_helper'

RSpec.xdescribe 'api/questions', type: :request do
  path '/api/questions' do
    get 'Questions' do
      tags 'Questions'
      consumes 'application/json'
      security [bearer_auth: []]
      response '200', 'question' do
        run_test!
      end
    end
  end

  path '/api/questions/{id}' do
    get 'Questions' do
      tags 'Questions'
      consumes 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :string
      response '200', 'question' do
        run_test!
      end
    end
  end

  path '/api/questions' do
    post 'Creates a question' do
      tags 'Questions'
      consumes 'application/json'
      security [bearer_auth: []]
      parameter name: :question, in: :body, schema: {
        type: :object,
        properties: {
          question: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string }
            },
            required: %w[name description]
          }
        },
        required: ['question']
      }

      response '200', 'question created' do
        let(:question) { { question: { name: 'bar', description: 'bar' } } }
      end

      response '422', 'invalid request' do
        let(:question) { { question: { name: 'foo' } } }
        run_test!
      end
    end
  end

  path '/api/questions/{id}' do
    put 'Updates a question' do
      tags 'Questions'
      consumes 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :string
      parameter name: :question, in: :body, schema: {
        type: :object,
        properties: {
          question: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string }
            },
            required: %w[name description]
          }
        },
        required: ['question']
      }

      response '200', 'question updated' do
        let(:question) { { question: { name: 'bar', description: 'bar' } } }
      end

      response '422', 'invalid request' do
        let(:question) { { question: { name: 'foo' } } }
        run_test!
      end
    end

    path '/api/questions/{id}' do
      delete 'Deletes a question' do
        tags 'Questions'
        consumes 'application/json'
        security [bearer_auth: []]
        parameter name: :id, in: :path, type: :string

        response '204', 'question deleted' do
          run_test!
        end
      end
    end
  end
end
