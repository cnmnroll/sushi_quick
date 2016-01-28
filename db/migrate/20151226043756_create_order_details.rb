class CreateOrderDetails < ActiveRecord::Migration
	def change
		create_table :order_details do |t|
			t.references :order, null: false
			t.references :merchandise, null: false
			t.integer :quantity, null: false
			t.integer :sub_total, null: false

			t.timestamps null: false
		end
		add_index :order_details, :merchandise_id
		add_index :order_details, :order_id
	end
end
