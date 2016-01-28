class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
			t.references :merchandise, null: false
			t.references :user, null: false
			t.integer :score, null: false
			t.string :title, null: false
			t.string :content, null: false
      t.timestamps null: false
    end
  end
end
