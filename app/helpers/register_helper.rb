module RegisterHelper
  
  def as_tags_csvs(coll)
    coll.join(", ")
  end

end
