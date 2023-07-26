class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, foreign_key: true

  after_save :update_likes_num

  private

  def update_likes_num
    post.increment!(:likes_counter)
  end
end
