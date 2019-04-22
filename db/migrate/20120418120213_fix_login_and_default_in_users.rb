class FixLoginAndDefaultInUsers < ActiveRecord::Migration
  def change
    change_column :users, :is_confirmed, :integer, :null => false, :default => 0
    change_column :users, :is_admin, :integer, :null => false, :default => 0
    change_column :users, :is_blocked, :integer, :null => false, :default => 0
  end
end
