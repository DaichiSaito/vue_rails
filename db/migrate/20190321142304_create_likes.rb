class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :from_id, null: false
      t.integer :to_id, null: false

      t.timestamps
    end
    add_index :likes, :from_id
    add_index :likes, :to_id
    add_index :likes, [:from_id, :to_id], unique: true
  end
end
