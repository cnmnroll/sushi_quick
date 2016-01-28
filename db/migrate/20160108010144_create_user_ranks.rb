class CreateUserRanks < ActiveRecord::Migration
  def change
    create_table :user_ranks do |t|
		t.string :name, null: false
		t.integer :lower_bound, null: false
		t.integer :upper_bound, null: false
		t.integer :discount, null: false
      	t.timestamps null: false
    end
  end
end
