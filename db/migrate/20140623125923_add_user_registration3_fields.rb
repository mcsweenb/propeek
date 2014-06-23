class AddUserRegistration3Fields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :company_name
      t.string :company_website
      t.string :job_title

      t.string :phone_1
      t.string :phone_2
      t.string :phone_3

      t.string :address_1
      t.string :address_2
      t.string :address_3

      t.string :state
      t.string :zip      

      add_money :users, :min_hourly, amount: {null: true, default: nil}
      add_money :users, :max_hourly, amount: {null: true, default: nil}
      add_money :users, :min_daily, amount: {null: true, default: nil}
      add_money :users, :max_daily, amount: {null: true, default: nil}

      t.string :fee_notes
    end
  end
end
