class AddUserLicensedInName < ActiveRecord::Migration

  def change
    add_column :users, :licensed_in, :string, :limit => 255
  end

end
