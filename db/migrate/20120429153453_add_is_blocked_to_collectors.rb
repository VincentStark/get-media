class AddIsBlockedToCollectors < ActiveRecord::Migration
  def change
    add_column :collectors, :is_blocked, :integer, :default => 0, :null => false
  end
end
