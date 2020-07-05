class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.integer :net_worth
      t.string :username
      t.string :password
    end
  end
end
