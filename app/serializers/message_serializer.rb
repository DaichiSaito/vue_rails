class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :user, :chatroom
end
