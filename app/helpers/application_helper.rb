module ApplicationHelper

  def year_range(range)
    "#{range.start_date.year} &dash; #{range.end_date.try(:year)}"
  end


end
