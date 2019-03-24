class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    payload = {
        room_id: message.chatroom.id,
        body: message.body,
        user: message.user,
        participants: message.chatroom.users.collect(&:id)
    }
    ActionCable.server.broadcast(build_room_id(message.chatroom.id), payload)
  end

  def build_room_id(id)
    "ChatRoom-#{id}"
  end
end
