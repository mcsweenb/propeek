
require 'csv'

namespace :propeek do
  namespace :sample_data do 

    desc "set addresses of all users in database to a random NYC address"
    task :set_all_addresses_to_ny => :environment  do
      filename = "#{__dir__}/../../db/sample_ny_addresses.csv"
      sample_addresses = CSV.read(filename, headers: true)
      User.find_each do |u|
        sample_row = sample_addresses[rand(sample_addresses.length)]
        u.address_1 = sample_row["ADDRESS"]
        u.address_2 = nil
        u.city = sample_row["CITY"]
        u.state = "New York"
        u.zip = sample_row["ZIP"]
        u.save
      end
    end

  end
end
