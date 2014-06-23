class ChangeAddress3ToCity < ActiveRecord::Migration
  def change
    rename_column :users, :address_3, :city
  end
end
