# class UserSerializer
#   include FastJsonapi::ObjectSerializer
#   attributes :name, :age
#   has_many :passive_likes, serializer: :like
#   has_many :be_liked_users, serializer: :user
# end


class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age_id, :avatar

  def avatar
    object.avatar.url
  end
end
