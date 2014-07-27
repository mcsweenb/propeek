json.array! @results do |result|
  json.fullname result.fullname
  json.avatar_url result.avatar.url(:profile_detail)
  json.profile_url profile_url(result)
  json.speciality result.speciality
  json.company_name result.company_name
  json.average_rating result.average_rating
  json.num_reviews result.num_reviews
end
