class CreateMerchandiseRelevances < ActiveRecord::Migration
  def change
    create_table :merchandise_relevances do |t|
			t.references :merchandise, null: false
			t.integer :target_id, null: false
			t.integer :quantity, null: false, default: 0
      t.timestamps null: false
    end
  end
end
