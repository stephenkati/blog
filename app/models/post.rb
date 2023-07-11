class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, :likes, dependent: :destroy

  after_save :update_posts_number

  def last_five_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_number
    author.increment!(:posts_counter)
  end
end
