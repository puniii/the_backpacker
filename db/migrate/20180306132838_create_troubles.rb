class CreateTroubles < ActiveRecord::Migration[5.1]
  def change
    create_table :troubles do |t|
      t.text :atm
      t.text :station
      t.text :bus
      t.text :pharmacy
      t.integer :post_id
    end
  end
end
