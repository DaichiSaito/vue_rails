class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :age
  has_many :passive_likes, serializer: :like
  has_many :be_liked_users, serializer: :user
end
