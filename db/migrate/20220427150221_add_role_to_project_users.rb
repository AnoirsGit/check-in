class AddRoleToProjectUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :project_users, :role, :integer, default: 1
  end
end
