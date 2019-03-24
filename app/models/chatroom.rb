class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :messages, dependent: :destroy

  def self.start_chat(users)
    user_ids = users.map(&:id).sort
    name = "DM:#{user_ids.join(':')}"
    chatroom = new(name: name)
    chatroom.users = users
    chatroom.save!
  end
end
