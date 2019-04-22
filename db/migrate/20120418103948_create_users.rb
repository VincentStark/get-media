class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :is_confirmed
      t.integer :is_admin
      t.integer :is_blocked

      t.timestamps
    end
  end
end
