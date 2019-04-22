class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :users, [ :email, :is_confirmed, :is_admin,
                        :is_blocked, :updated_at, :created_at ],
              unique: true, name: "index_users_composite1"
  end
end
