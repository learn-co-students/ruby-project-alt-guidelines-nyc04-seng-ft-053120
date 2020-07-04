class CreateJokes < ActiveRecord::Migration[5.2]
  def change
    create_table :jokes do |t|
      t.text :content
      t.string :genre
      t.integer :like_id
      
      t.timestamp 
    end
  end
end
