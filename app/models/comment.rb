class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  has_many :likes, dependent: :destroy

  after_save :update_comments_num

  private

  def update_comments_num
    post.increment!(:comments_counter)
  end
end
