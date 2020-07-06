class CreateUserresources < ActiveRecord::Migration[5.2]
  def change
    create_table :userresources do |t| 
     # t.integer :username #do we need a username?
      t.integer :user_id
      t.integer :resource_id
    end
  end
end
