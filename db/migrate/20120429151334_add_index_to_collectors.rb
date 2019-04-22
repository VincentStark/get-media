class AddIndexToCollectors < ActiveRecord::Migration
  def change
    add_index :collectors, :ip, unique: true
    add_index :collectors, [ :ip, :uptime, :status, :host_os,
                             :host_la, :storage_used, :storage_free,
                             :memory_used, :downloads_total,
                             :downloads_in_progress, :downloads_failed,
                             :downloads_bitrate ],
              unique: true, name: "index_collectors_composite1"
  end
end
