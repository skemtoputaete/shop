class AddRolesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin_role, :boolean, default: false
    add_column :users, :supervisor_role, :boolean, default: false
    add_column :users, :user_role, :boolean, default: true
  end
end
