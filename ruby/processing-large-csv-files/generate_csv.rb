# http://dalibornasevic.com/posts/68-processing-large-csv-files-with-ruby?utm_source=rubyweekly&utm_medium=email
# Processing large CSV files with Ruby

require 'csv'
require_relative './helpers'

headers = ['id', 'name', 'email', 'city', 'street', 'country']

name    = "Pink Panther"
email   = "pink.panther@example.com"
city    = "Pink City"
street  = "Pink Road"
country = "Pink Country"

print_memory_usage do
  print_time_spent do
    CSV.open('data.csv', 'w', write_headers: true, headers: headers) do |csv|
      1000000.times do |i|
        csv << [i, name, email, city, street, country]
      end
    end
  end
end
