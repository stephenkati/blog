require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author:, title: 'Nature', text: 'This is exciting!') }
  subject { Comment.new(post:, author:, text: 'This is my comment') }
  before { subject.save }

  context 'return updated comments counter' do
    it 'increments the post\'s comments_counter on save' do
      expect { subject.save }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
