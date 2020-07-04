class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.integer :age
      t.text :bio
      t.string :cohort
      t.datetime :member_since
      t.string :password
      t.integer :num_of_minion_followed
      t.integer :minion_id
      t.boolean :status
      
      t.timestamp
    end
  end
end
