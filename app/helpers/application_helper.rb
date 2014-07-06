module ApplicationHelper

  def year_range(range)
    "#{range.start_date.year} &dash; #{range.end_date.try(:year)}"
  end

  def reviewer_avatar(review, format)
    if review.review_by
      review.review_by.avatar.url(format)
    else
      'content/comment-thumb1.jpg'
    end
  end

end
