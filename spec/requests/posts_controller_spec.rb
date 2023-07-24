require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET posts#index' do
    let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photo', bio: 'bio') }
    let(:post) { Post.create(title: 'Post', text: 'My post', author_id: user.id) }

    it 'returns a success response' do
      get user_posts_path(user)

      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      get user_posts_path(user)

      expect(response).to render_template(:index)
    end
  end

  describe 'GET posts#show' do
    let(:user) { User.create(name: 'John', photo: 'https://unsplash.com/photo', bio: 'bio') }
    let(:post) { Post.create(title: 'Post', text: 'My post', author_id: user.id) }

    it 'returns a success response' do
      get user_post_path(user, post)

      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      get user_post_path(user, post)

      expect(response).to render_template(:show)
    end
  end
end
