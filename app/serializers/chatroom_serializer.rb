class ChatroomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :users do |object|
    object.users.select :id, :name, :age
  end
  has_many :users
  # has_many :chatroom_users
end
