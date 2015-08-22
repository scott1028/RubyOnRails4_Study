class AddPrivilegeColumn < ActiveRecord::Migration
  def change
    add_column :privileges, :role_id, :string
  end
end
