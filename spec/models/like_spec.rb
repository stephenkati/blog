require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'New user') }
  let(:post) { Post.new(author: user, title: 'Nature', text: 'This is exciting!') }
  subject { Like.new(post:, author: user) }
  before { subject.save }

  it 'method update_likes_counter increments likes_counter by 1' do
    expect { subject.send(:update_likes_num) }.to change { post.reload.likes_counter }.by(1)
  end
end
