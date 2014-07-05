class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :review_for_id
      t.integer :review_by_id
      t.string :review
      t.integer :rating

      t.timestamps
    end

    add_index :reviews, :review_for_id
    add_index :reviews, :review_by_id
    add_index :reviews, :created_at    
  end
end
