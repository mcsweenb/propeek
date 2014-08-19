json.array! @specialities do |speciality|
  json.text speciality.name
  json.value speciality.name
end
