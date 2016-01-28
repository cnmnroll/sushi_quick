class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
		    t.references :user, null: false
      	t.string :user_address, null: false
      	t.integer :total, null: false
      	t.integer :delivery_status, null: false, default: 1
      	t.timestamps null: false
    end

    add_index :orders, :user_id
  end
end
