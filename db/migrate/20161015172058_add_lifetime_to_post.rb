class AddLifetimeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :lifetime, :integer
  end
end
