class AddCompositeIndexToCollectors < ActiveRecord::Migration
  def change
    remove_index :collectors, name: "index_collectors_composite1"
    add_index :collectors, [ :ip, :uptime, :status, :host_os,
                             :host_la, :storage_used, :storage_free,
                             :memory_used, :downloads_total,
                             :downloads_in_progress, :downloads_failed,
                             :downloads_bitrate, :is_blocked, :checked_at ],
              unique: true, name: "index_collectors_composite1"
  end
end
