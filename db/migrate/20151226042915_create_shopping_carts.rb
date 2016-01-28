class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
		t.references :user, null: false
		t.integer :total, null: false, default: 0
		t.string :address
   		t.timestamps null: false
    end

    add_index :shopping_carts, :user_id
  end
end
