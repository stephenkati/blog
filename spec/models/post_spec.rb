require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { Post.create }

  context 'Testing with no inputs' do
    it 'should not be valid' do
      expect(post).to_not be_valid
    end

    it 'likes counter must be 0 or greater' do
      expect(post.likes_counter).to be >= 0
      expect(post.likes_counter).to be_a(Integer)
    end

    it 'comments counter must be 0 or greater' do
      expect(post.comments_counter).to be >= 0
      expect(post.comments_counter).to be_a(Integer)
    end

    it 'return last five posts' do
      expect(post.last_five_comments).to eq(post.comments.order(updated_at: :desc).limit(5))
    end
  end

  context 'Testing with inputs' do
    let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'New user') }
    subject { Post.new(author: user, title: 'Nature', text: 'This is exciting!') }
    before { subject.save }

    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'should have comments_counter equal to 0' do
      expect(subject.comments_counter).to eq(0)
    end

    it 'should have likes_counter equal to 0' do
      expect(subject.likes_counter).to eq(0)
    end

    it 'title should not be greater than 250 characters' do
      post = Post.create(author: user, title: 'a' * 251, text: 'This is exciting!')
      expect(post).not_to be_valid
    end

    it 'increments the author\'s post_counter on save' do
      expect { subject.save }.to change { user.reload.posts_counter }.by(1)
    end
  end
end
