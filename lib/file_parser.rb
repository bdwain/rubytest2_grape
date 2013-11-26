require_relative 'record'

class FileParser
  def parse_file(file_path)
    result_set = Array.new
    File.open(file_path) do |file|
      file.each_line do |line|
        record = Record.new
        record.parse(line)
        result_set.push(record)
      end
    end
    result_set
  end
end