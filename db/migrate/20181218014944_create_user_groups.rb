class CreateUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_groups do |t|
      t.references :user
      t.references :group
      t.timestamps
    end
  end
end
