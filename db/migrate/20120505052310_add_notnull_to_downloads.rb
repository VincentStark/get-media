class AddNotnullToDownloads < ActiveRecord::Migration
  def change
    change_column :downloads, :collector_id, :integer, :null => false
    change_column :downloads, :user_id, :integer, :null => false
    change_column :downloads, :url, :string, :null => false
    change_column :downloads, :status, :integer, :null => false, :default => 1
    change_column :downloads, :type, :integer, :null => false
    change_column :downloads, :title, :string, :null => false
    change_column :downloads, :author, :string, :null => false
    change_column :downloads, :length, :integer, :null => false
    change_column :downloads, :size, :integer, :null => false
    change_column :downloads, :progress, :integer, :null => false
    change_column :downloads, :quality, :integer, :null => false
  end
end
