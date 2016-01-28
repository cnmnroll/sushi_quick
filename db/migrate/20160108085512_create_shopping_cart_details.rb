class CreateShoppingCartDetails < ActiveRecord::Migration
  def change
    create_table :shopping_cart_details do |t|
      t.references :shopping_cart, null: false
      t.references :merchandise, null: false
      t.integer :quantity, null: false
      t.integer :sub_total, null: false
      t.timestamps null: false
    end
    add_index :shopping_cart_details, :shopping_cart_id
    add_index :shopping_cart_details, :merchandise_id
  end
end
