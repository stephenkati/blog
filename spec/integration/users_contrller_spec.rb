# spec/integration/users_controller_spec.rb
# rubocop:disable all
require 'swagger_helper'

describe 'Users API' do
  path '/api/v1/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'Users found' do
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
                       name: { type: :string },
                       photo: { type: :string },
                       bio: { type: :string },
                       email: { type: :string },
                       posts_counter: { type: :integer }
                     },
                     required: %w[id name photo bio email posts_counter]
                   }
                 }
               },
               required: %w[status message data]

        examples 'application/json' => {
          status: 'Success',
          message: 'Users fetched successfully',
          data: [
            { id: 1,
              name: 'Denver',
              photo: 'image_url',
              bio: 'Miguel Ángel García de la Herrán, best known as Miguel Herrán, is a Spanish actor.',
              email: '<EMAIL>',
              posts_counter: 2 },
            { id: 2,
              name: 'Professor',
              photo: 'image_url',
              bio: 'A criminal mastermind who has dedicated his life to planning the perfect heist.',
              email: '<EMAIL>',
              posts_counter: 3 }
          ]
        }

        run_test!
      end

      response '404', 'Users not found' do
        examples 'application/json' => {
          status: 'Error',
          message: 'Failed to fetch users!',
          errors: 'Users not found!'
        }

        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'show a user with given ID.' do
      tags 'User'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'User found' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     photo: { type: :string },
                     bio: { type: :string },
                     email: { type: :string },
                     posts_counter: { type: :integer }
                   },
                   required: %w[id name photo bio email posts_counter]
                 }
               },
               required: %w[status message data]

        examples 'application/json' => {
          status: 'Success',
          message: 'User fetched successfully',
          data: {
            id: 1,
            name: 'Denver',
            photo: 'image_url',
            bio: 'Miguel Ángel García de la Herrán, best known as Miguel Herrán, is a Spanish actor.',
            email: '<EMAIL>',
            posts_counter: 2
          }
        }

        run_test!
      end

      response '404', 'User not found' do
        examples 'application/json' => {
          status: 'Error',
          message: 'Failed to fetch user!',
          errors: "User not found with id: 'invalid'"
        }

        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
