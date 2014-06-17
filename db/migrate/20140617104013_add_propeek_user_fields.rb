class AddPropeekUserFields < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :limit => 128, :null => false
    add_column :users, :last_name, :string, :limit => 128, :null => false
    add_column :users, :bio, :string, :null => false
    add_column :users, :linkedin_handle, :string
    add_column :users, :twitter_handle, :string
  end
end
