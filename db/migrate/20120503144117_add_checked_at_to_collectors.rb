class AddCheckedAtToCollectors < ActiveRecord::Migration
  def change
    add_column :collectors, :checked_at, :datetime
  end
end
