class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.string :name, limit: 64
    end
    add_column :users, :profession_name, :string, limit: 64
    User.update_all profession_name: "Accountant"
  end
end
