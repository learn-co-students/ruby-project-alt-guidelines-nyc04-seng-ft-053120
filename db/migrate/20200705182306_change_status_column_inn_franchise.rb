class ChangeStatusColumnInnFranchise < ActiveRecord::Migration[5.2]
  def change
    remove_column :franchises, :status, :string
    add_column :franchises, :open, :boolean 
  end
end
