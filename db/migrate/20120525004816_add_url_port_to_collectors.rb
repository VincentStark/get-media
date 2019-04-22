class AddUrlPortToCollectors < ActiveRecord::Migration
  def change
    add_column :collectors, :url_port, :integer, :null => false, :default => 8081
  end
end
