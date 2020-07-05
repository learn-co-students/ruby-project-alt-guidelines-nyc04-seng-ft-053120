class EditDateInFranchise < ActiveRecord::Migration[5.2]
  def change
    remove_column :franchises, :year_opened, :integer
    add_column :franchises, :date_opened, :date
  end
end
