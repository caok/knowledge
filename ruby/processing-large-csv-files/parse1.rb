#Reading CSV from a file at once (CSV.read)
#整个csv的对象都在内存中
#That causes lots of String objects to be created by the CSV library and the used memory is much more higher than the actual size of the CSV file.

require_relative './helpers'
require 'csv'

print_memory_usage do
  print_time_spent do
    csv = CSV.read('data.csv', headers: true)
    sum = 0

    csv.each do |row|
      sum += row['id'].to_i
    end

    puts "Sum: #{sum}"
  end
end

