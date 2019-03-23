class LikeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :from_id, :to_id
  belongs_to :from, serializer: :user
  belongs_to :to, serializer: :user
end
