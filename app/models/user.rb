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
  has_many :chatroom_users, dependent: :destroy
  has_many :chatrooms, through: :chatroom_users
  has_many :messages, dependent: :destroy

  # ユーザーをいいねする
  def like(other_user)
    like_users << other_user
  end

  # いいねを既読状態にする
  def read_like_by(other_user)
    passive_likes.find_by(from_id: other_user.id).update!(read_at: Time.current)
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def liking?(other_user)
    like_users.include?(other_user)
  end
end
