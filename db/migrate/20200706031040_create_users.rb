class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name
      t.integer :age
      t.string :borough
    end
  end
end
