class CreateMinions < ActiveRecord::Migration[5.2]
  def change
    create_table :minions do |t|
      t.integer :user_id
      t.integer :minions_counter
    end
  end
end
