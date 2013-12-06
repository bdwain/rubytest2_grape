require_relative 'record'

class FileParser
  def parse_file(file_path)
    result_set = Array.new
    begin
      File.open(file_path) do |file|
        file.each_line do |line|
          parser = RecordParser.new(line)
          parser.parse
          record = Record.new(parser.last_name, parser.first_name, parser.gender, parser.favorite_color, parser.date_of_birth)
          result_set.push(record)
        end
      end
    rescue Errno::ENOENT
    end
    result_set
  end
end