rank = 0
json.users @results do |user|
  rank += 1
  json.id user.id
  json.avatar_url user.avatar.url(:profile_detail)
  json.rank rank
  json.fullname user.fullname
  json.profile_url profile_url(user)
  json.speciality user.speciality
  json.company user.company_name
  json.average_rating user.average_rating
  json.num_reviews user.num_reviews
  json.lon user.try(:lonlat).try(:lon)
  json.lat user.try(:lonlat).try(:lat)
end
