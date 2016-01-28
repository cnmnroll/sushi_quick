class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :user_address, null: false
      t.string :user_lo, null: false, unique: true
      t.string :user_ps, null: false
			t.string :user_email
			t.integer :user_status, null: false, default: 1
			t.integer :total, null: false, default: 0
			t.references :user_rank, null: false, default: 1
      t.timestamps null: false
    end
  end
end
