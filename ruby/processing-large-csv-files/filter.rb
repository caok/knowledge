file_name = "UA_BLOCK_PP_Android.csv"
file_new_name = "UA_BLOCK_PP_Android_new.csv"

require 'csv'

count = 0

CSV.open(file_new_name, 'w', {:force_quotes=>true}) do |csv|
  CSV.foreach(file_name) do |row|
    #break if count > 10
    str = row.first
    if str.length <= 36 && (str.downcase == str || str.downcase.match(/\b(select|null|=|and|count|concat|group|from|all|union|order|by|<|>)\b/).nil?)
      count += 1
      csv << [str]
      puts str if str.length < 30
    else
      puts str
    end
  end
end

puts "-------------"*20
puts "Count: #{count}"
puts "-------------"*20
