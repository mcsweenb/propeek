class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :qualification
      t.string :institution
      t.date :start_date
      t.date :end_date
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
