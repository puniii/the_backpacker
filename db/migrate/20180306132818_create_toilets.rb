class CreateToilets < ActiveRecord::Migration[5.1]
  def change
    create_table :toilets do |t|
      t.text :information
      t.text :comfortable
      t.text :box_number
      t.text :baggage
      t.integer :post_id
    end
  end
end
