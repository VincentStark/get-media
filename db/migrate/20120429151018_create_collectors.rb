class CreateCollectors < ActiveRecord::Migration
  def change
    create_table :collectors do |t|
      t.string :ip, :null => false
      t.integer :uptime, :null => false
      t.integer :status, :null => false
      t.string :host_os, :null => false
      t.string :host_la, :null => false
      t.integer :storage_used, :null => false
      t.integer :storage_free, :null => false
      t.integer :memory_used, :null => false
      t.integer :downloads_total, :null => false
      t.integer :downloads_in_progress, :null => false
      t.integer :downloads_failed, :null => false
      t.integer :downloads_bitrate, :null => false

      t.timestamps
    end
  end
end
