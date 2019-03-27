class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :messages, dependent: :destroy

  scope :without_messages, -> { left_joins(:messages).select('*').where('messages.id IS NULL') }
  scope :unread, -> { joins(:messages).merge(Message.order(id: :desc).limit(1)).where('chatroom_users.last_read_at < messages.created_at') }

  def self.start_chat(users)
    user_ids = users.map(&:id).sort
    name = "DM:#{user_ids.join(':')}"
    chatroom = new(name: name)
    chatroom.users = users
    chatroom.save!
  end
end
