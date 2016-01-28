class CreateMerchandises < ActiveRecord::Migration
  def change
    create_table :merchandises do |t|
      t.string :merchandise_name, null: false, unique: true, presence: true
      t.integer :price, null: false
      t.integer :stock, null: false
      t.integer :category, null: false
      t.integer :sub_category, null: false
      t.integer :type_status, null: false
			t.boolean :display, null: false, default: true
			t.boolean :recommend, null: false, default: false
			t.binary :data
			t.string :content_type
			t.integer :sales, null: false, default: 0
      t.timestamps null: false
    end
  end
end
