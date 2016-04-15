class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.references :brand, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.decimal :price, null: false
      t.integer :quantity_of_stock, null: false
    end
  end
end
