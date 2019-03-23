class User < ApplicationRecord
  has_many :authentications, dependent: :destroy
  has_many :active_likes, class_name: 'Like',
           foreign_key: 'from_id',
           dependent: :destroy
  has_many :passive_likes, class_name: 'Like',
           foreign_key: 'to_id',
           dependent: :destroy
  has_many :like_users, through: :active_likes, source: :to
  has_many :be_liked_users, through: :passive_likes, source: :from

  # ユーザーをスキップする
  def like(other_user)
    like_users << other_user
  end
end
