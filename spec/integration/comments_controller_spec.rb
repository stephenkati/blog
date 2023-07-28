# spec/integration/comments_controller_spec.rb
# rubocop:disable all
require 'swagger_helper'

describe 'Comments API' do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves all comments' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer

      response '200', 'Comments found' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       text: { type: :string },
                       post_id: { type: :integer },
                       author_id: { type: :integer }
                     },
                     required: %w[id text post_id author_id]
                   }
                 }
               },
               required: %w[status message data]

        examples 'application/json' => {
          status: 'Success',
          message: 'Comment fetched successfully',
          data: [
            { id: 1, text: 'This is my first comment', post_id: 1, author_id: 1 },
            { id: 2, text: 'This is my second comment', post_id: 1, author_id: 1 }
          ]
        }

        run_test!
      end

      response '404', 'Comments not found' do
        examples 'application/json' => {
          status: 'Error',
          message: 'No comments found!',
          errors: "Comments not found for post with id: 'invalid'"
        }

        let(:post_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          post_id: { type: :integer },
          author_id: { type: :integer }
        },
        required: %w[text post_id author_id]
      }

      response '200', 'Comment created' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     text: { type: :string },
                     post_id: { type: :integer },
                     author_id: { type: :integer }
                   },
                   required: %w[id text post_id author_id]
                 }
               },
               required: %w[status message data]

        examples 'application/json' => {
          status: 'Success',
          message: 'Comment Created',
          data: { id: 1, text: 'This is my first comment', post_id: 1, author_id: 1 }
        }

        let(:comment) { { text: 'This is my first comment', post_id: 1, author_id: 1 } }
        run_test!
      end

      response '422', 'Invalid request' do
        examples 'application/json' => {
          status: 'Not Found',
          message: 'Details not found',
          data: { text: ["can't be blank"], post_id: ["can't be blank"], author_id: ["can't be blank"] }
        }

        let(:comment) { { text: '', post_id: '', author_id: '' } }
        run_test!
      end
    end
  end
end
