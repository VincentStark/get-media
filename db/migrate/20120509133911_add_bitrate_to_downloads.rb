class AddBitrateToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :bitrate, :integer
  end
end
