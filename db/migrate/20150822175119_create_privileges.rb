class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.string :privilege_id
      t.string :privilege_label

      t.timestamps null: false
    end
  end
end
