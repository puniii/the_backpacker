class AddColumnToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :star, :integer
    add_column :comments, :wifi, :text
    add_column :comments, :toilet, :text
    add_column :comments, :trouble, :text
  end
end
