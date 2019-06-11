class RemoveAdminFromTeachers < ActiveRecord::Migration[5.2]
  def change
    remove_column :teachers, :admin, :boolean
  end
end
