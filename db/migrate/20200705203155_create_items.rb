class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.text :description
      t.integer :quantity
    end
  end
end
