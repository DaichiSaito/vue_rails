class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.integer :age_id

      t.timestamps
    end

    add_index :users, :age_id
  end
end
