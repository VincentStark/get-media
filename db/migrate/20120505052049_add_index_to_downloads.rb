class AddIndexToDownloads < ActiveRecord::Migration
  def change
    add_index :downloads, [ :collector_id, :user_id, :url ],
              unique: true, name: "index_downloads_composite1"
    add_index :downloads, [ :collector_id, :user_id, :url, :status,
                            :type, :title, :author, :length, :size,
                            :progress, :quality ],
              unique: true, name: "index_downloads_composite2"
  end
end
