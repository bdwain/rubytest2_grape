require_relative 'lib/file_parser'
require_relative 'lib/record_set'

parser = FileParser.new
records = RecordSet.new

ARGV.each do |arg|
  records.add_records(parser.parse_file(arg))
end

puts "Records sorted by gender and then last name ascending: "
records.get_records_by_gender.each do |record|
  puts record.to_s
end

puts ""

puts "Records sorted by birth date ascending: "
records.get_records_by_birth_date_ascending.each do |record|
  puts record.to_s
end

puts ""

puts "Records sorted by last name descending: "
records.get_records_by_last_name_descending.each do |record|
  puts record.to_s
end