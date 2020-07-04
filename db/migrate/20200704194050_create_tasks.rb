class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :completed
      t.datetime :due_time
      t.integer :project_id
      t.integer :user_id
    end
  end
end
