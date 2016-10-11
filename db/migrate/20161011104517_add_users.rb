class AddUsers < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :username
      t.string :password
      t.timestamps
    end
  end
end
