class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :joke_id
      t.integer :like_id
      t.text :content
      t.datetime :posted
      
      t.timestamp
    end
  end
end
