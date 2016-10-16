class AddVisitedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :visited, :boolean, default: false
  end
end
