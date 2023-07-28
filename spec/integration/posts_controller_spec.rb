# spec/integration/posts_controller_spec.rb
# rubocop:disable all
require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/users/{user_id}/posts' do
    get 'Retrieves all posts' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'Posts found' do
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
                       title: { type: :string },
                       text: { type: :string },
                       comments_counter: { type: :integer },
                       likes_counter: { type: :integer },
                       author_id: { type: :integer }
                     },
                     required: %w[id title text comments_counter likes_counter author_id]
                   }
                 }
               },
               required: %w[status message data]

        examples 'application/json' => {
          status: 'Success',
          message: 'Posts fetched successfully',
          data: [
            { id: 1, title: 'Post 1', text: 'This is my first post', comments_counter: 0, likes_counter: 0,
              author_id: 1 },
            { id: 2, title: 'Post 2', text: 'This is my second post', comments_counter: 0, likes_counter: 0,
              author_id: 1 }
          ]
        }

        run_test!
      end

      response '404', 'Posts not found' do
        examples 'application/json' => {
          status: 'Error',
          message: 'Failed to fetch posts!',
          errors: "Posts not found for user with id: 'invalid'"
        }

        let(:user_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{id}' do
    get 'Retrieves a specific post' do
      tags 'Post'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer

      response '200', 'Post found' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     title: { type: :string },
                     text: { type: :string },
                     comments_counter: { type: :integer },
                     likes_counter: { type: :integer },
                     author_id: { type: :integer }
                   },
                   required: %w[id title text comments_counter likes_counter author_id]
                 }
               },
               required: %w[status message data]

        examples 'application/json' => {
          status: 'Success',
          message: 'Post fetched successfully',
          data: { id: 1, title: 'Post 1', text: 'This is my first post', comments_counter: 0, likes_counter: 0,
                  author_id: 1 }
        }

        run_test!
      end

      response '404', 'Post not found' do
        examples 'application/json' => {
          status: 'Error',
          message: 'Failed to fetch post!',
          errors: "Post not found for user with id: 'invalid' and post id: 'invalid'"
        }

        let(:user_id) { 'invalid' }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
