class AddThumbnailToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :thumbnail, :string
  end
end
