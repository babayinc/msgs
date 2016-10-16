class AddSinglevisitToPost < ActiveRecord::Migration
  def change
    add_column :posts, :singlevisit, :boolean, default: false
  end
end
