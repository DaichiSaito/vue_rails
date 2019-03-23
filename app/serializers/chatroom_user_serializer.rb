class ChatroomUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :chatroom_id
  belongs_to :user
  belongs_to :chatroom
end
