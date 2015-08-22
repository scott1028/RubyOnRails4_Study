class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.text :label
      t.text :content

      t.timestamps null: false
    end
  end
end
