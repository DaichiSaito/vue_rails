class ChatroomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  scope :unopened, -> { where(last_read_at: nil) }
end
