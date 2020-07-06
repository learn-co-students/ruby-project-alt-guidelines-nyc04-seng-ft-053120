class CreateUserresources < ActiveRecord::Migration[5.2]
  def change
    create_table :userresources do |t| 
      t.integer :user_id
      t.integer :resource_id
      t.string :borough
      t.string :practitioner
    end
  end
end
