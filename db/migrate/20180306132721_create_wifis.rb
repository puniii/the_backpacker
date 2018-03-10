class CreateWifis < ActiveRecord::Migration[5.1]
  def change
    create_table :wifis do |t|
      t.text :condition_1
      t.text :condition_2
      t.text :condition_3
      t.integer :post_id
    end
  end
end
