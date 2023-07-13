require 'rails_helper'

RSpec.describe User, type: :model do
  context 'testing user with no values' do
    subject { User.new }
    before { subject.save }

    it 'require user to have name' do
      expect(subject).to_not be_valid
    end

    it 'posts counter should be an integer and greater than or equal to zero' do
      expect(subject.posts_counter).to be_a(Integer)
      expect(subject.posts_counter).to be >= 0
    end
  end
  context 'testing user with values' do
    subject(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
    before { user.save }

    it 'user with name should be valid' do
      expect(user).to be_valid
    end

    it 'posts counter should be equal to 0' do
      expect(user.posts_counter).to eq(0)
    end
  end
end
