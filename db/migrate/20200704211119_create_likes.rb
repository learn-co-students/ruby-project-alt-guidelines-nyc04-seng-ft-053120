class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :joke_id
      t.integer :like_counter
    end
  end
end
