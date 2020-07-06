class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :practitioner
      t.string :location
      t.integer :borough
      t.string :url
    end
  end
end

