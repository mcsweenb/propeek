class CreateSpecialitiesUsers < ActiveRecord::Migration
  def change
    create_table :specialities_users do |t|
      t.integer :speciality_id
      t.integer :user_id
    end
  end
end
