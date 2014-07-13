# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w(Accountant).each do |profession_name|
  Profession.create!(name: profession_name)
end

['All Services',
 'Audit Services',
 'Bookkeeping',
 'Budgeting and Planning',
 'Business Accounting Services',
 'Business Financial Planning',
 'Business Tax Returns',
 'Cash Flow Analysis',
 'CFO Services',
 'Controller Services',
 'Employee Benefits',
 'Estate Planning',
 'Forecasting and Projections',
 'Forensic accountants',
 'Individual Accounting Services',
 'Individual Tax Returns',
 'Payroll Tax Services',
 'Taxation professional'].each do |speciality_name| 
  Speciality.create!(name: speciality_name)
end
