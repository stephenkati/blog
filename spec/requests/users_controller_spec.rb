require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'Get users#index' do
    it 'returns a success response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end
  describe 'Get users#show' do
    let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photo', bio: 'bio') }

    it 'returns a success response' do
      get "/users/#{user.id}"

      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      get "/users/#{user.id}"

      expect(response).to render_template(:show)
    end
  end
end
