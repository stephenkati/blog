require 'rails_helper'

describe 'posts', type: :feature do
  describe '#index' do
    before(:each) do
      @user = User.create(name: 'Jimmy', bio: 'This is user page', photo: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=
      # M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80')

      @post1 = Post.create(title: 'Hello', text: 'This is my first post', author_id: @user.id)
      @post2 = Post.create(title: 'Adventure', text: 'Checkout this waterfall', author_id: @user.id)
      @post3 = Post.create(title: 'Movie date', text: 'This is how movie night should be like!', author_id: @user.id)
      @post4 = Post.create(title: 'Wind', text: 'Silent breeze', author_id: @user.id)

      @comment1 = Comment.create(text: 'Hey there, how is it going?', author_id: @user.id, post_id: @post2.id)
      @comment2 = Comment.create(text: 'Nice to see you around!', author_id: @user.id, post_id: @post2.id)
      @comment3 = Comment.create(text: 'Great shot, Lisa!', author_id: @user.id, post_id: @post1.id)
      @comment4 = Comment.create(text: 'I love your photography skills!', author_id: @user.id, post_id: @post3.id)
      @comment5 = Comment.create(text: 'This is so inspiring!', author_id: @user.id, post_id: @post4.id)

      @like = Like.create(author_id: @user.id, post_id: @post2.id)
      @like = Like.create(author_id: @user.id, post_id: @post2.id)
      @like = Like.create(author_id: @user.id, post_id: @post2.id)
      @like = Like.create(author_id: @user.id, post_id: @post2.id)
      @like = Like.create(author_id: @user.id, post_id: @post2.id)
      @like = Like.create(author_id: @user.id, post_id: @post2.id)

      visit user_posts_path(@user)
    end

    it 'displays user information' do
      expect(page).to have_css('img')
      expect(page).to have_content('Jimmy')
      expect(page).to have_content('Number of posts: 4')
    end

    it 'displays post information' do
      expect(page).to have_content('Hello')
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('Likes: 0')
      expect(page).to have_content('Comments: 1')
    end

    it 'displays the first comments on a post' do
      expect(page).to have_content('Hey there, how is it going?')
      expect(page).to have_content('Nice to see you around!')
    end

    it 'displays the number of comments and likes for a post' do
      expect(page).to have_content('Comments: 2')
      expect(page).to have_content('Likes: 6')
    end

    it 'redirects to the post when clicked' do
      click_link('Hello')
      expect(current_path).to eq(user_post_path(@user, @post1))
    end
  end

  describe '#show', type: :feature do
    before(:each) do
      @user = User.create(name: 'Lisa', bio: 'Teacher from USA', photo: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80')

      @user1 = User.create(name: 'Jimmy', bio: 'This is user page', photo: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80')

      @post = Post.create(title: 'Adventure', text: 'Checkout this waterfall', author_id: @user.id)

      @comment = Comment.create(text: 'Great shot, Lisa!', author_id: @user1.id, post_id: @post.id)

      @like = Like.create(author_id: @user.id, post_id: @post.id)
      @like = Like.create(author_id: @user.id, post_id: @post.id)

      visit user_post_path(@user, @post)
    end

    it 'displays post title, text, author, comments and likes count' do
      expect(page).to have_content('Adventure')
      expect(page).to have_content('Checkout this waterfall')
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Likes: 2')
    end

    it 'displays posts comments, comments author' do
      expect(page).to have_content('Jimmy: Great shot, Lisa!')
    end
  end
end
