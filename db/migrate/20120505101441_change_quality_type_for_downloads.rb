class ChangeQualityTypeForDownloads < ActiveRecord::Migration
  def change
    change_column :downloads, :quality, :string, :null => false
  end
end
