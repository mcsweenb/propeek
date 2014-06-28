class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :company_name
      t.string :company_website
      t.string :title
      t.date :start_date
      t.date :end_date
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
