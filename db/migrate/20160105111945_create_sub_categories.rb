class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
		t.string :sub_category_name, null: false
      	t.timestamps null: false
    end
  end
end
