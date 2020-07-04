class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :summary
      t.string :location

      t.timestamp
    end
  end
end
