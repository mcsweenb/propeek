class AddProfessionSpecialityRelationship < ActiveRecord::Migration
  def change
    add_column :specialities, :profession_id, :integer
    add_index :specialities, :profession_id
    Speciality.where("profession_id is null").each do |s|
      s.profession = Profession.all.sample
      s.save
    end
  end
end
