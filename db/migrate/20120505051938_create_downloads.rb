class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :collector_id
      t.integer :user_id
      t.string :url
      t.integer :status
      t.integer :type
      t.string :title
      t.string :author
      t.integer :length
      t.integer :size
      t.integer :progress
      t.integer :quality

      t.timestamps
    end
  end
end
