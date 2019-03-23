class AddConfirmedAtToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :read_at, :datetime
  end
end
