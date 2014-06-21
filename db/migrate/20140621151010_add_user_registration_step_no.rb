class AddUserRegistrationStepNo < ActiveRecord::Migration

  def change
    add_column :users, :registration_step_number, :integer
  end

end
