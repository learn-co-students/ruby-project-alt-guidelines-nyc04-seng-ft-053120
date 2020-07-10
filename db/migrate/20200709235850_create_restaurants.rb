class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :rest_name
      t.string :borough
      t.integer :stars
  end
end
