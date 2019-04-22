class DelDownloadsFromCollectors < ActiveRecord::Migration
  def change
    remove_column :collectors, :downloads_total
    remove_column :collectors, :downloads_in_progress
    remove_column :collectors, :downloads_failed
    remove_column :collectors, :downloads_bitrate
  end
end
