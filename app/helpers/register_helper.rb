module RegisterHelper
  
  def as_tags_csvs(coll)
    coll.map(&:name).join(", ")
  end

end
