class CreateFranchises < ActiveRecord::Migration[5.2]
  def change
    create_table :franchises do |t|
      t.string :name
      t.integer :company_id
      t.integer :owner_id
      t.string :location
      t.integer :year_opened
      t.integer :profit
      t.string :status
    end
  end
end
