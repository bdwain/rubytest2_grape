require_relative 'record'

class FileParser
  def parse_file(file_path)
    result_set = Array.new
    begin
      File.open(file_path) do |file|
        file.each_line do |line|
          parser = RecordParser.new(line)
          parser.parse
          record = Record.new(last_name: parser.last_name, first_name: parser.first_name, gender: parser.gender, favorite_color: parser.favorite_color, date_of_birth: parser.date_of_birth)
          result_set.push(record)
        end
      end
    rescue Errno::ENOENT
    end
    result_set
  end
end