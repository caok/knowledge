require_relative './helpers'
require 'csv'

print_memory_usage do
  print_time_spent do
    sum = 0

    # A Line at a Time
    CSV.foreach('data.csv', headers: true) do |row|
      sum += row['id'].to_i
    end

    puts "Sum: #{sum}"
  end
end
