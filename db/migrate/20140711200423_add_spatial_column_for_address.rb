class AddSpatialColumnForAddress < ActiveRecord::Migration
  def change
    add_column :users, :lonlat, :point, geographic: true
    add_index :users, :lonlat, spatial: true
  end
end
