require 'file_parser'
require 'record_set'
require 'record'
require 'record_parser'
require 'grape'
require 'record_set_serializer'

module RecordApi
  class API < Grape::API
    format :json

    helpers do
      #gets the path to the record file where all of the records are stored
      def get_record_filename
        "records.txt"
      end

      #gets a RecordSet built from the current contents of the record file
      def get_current_record_set
        parser = FileParser.new
        record_set = RecordSet.new
        record_set.add_records(parser.parse_file(get_record_filename))
        record_set
      end
    end

    resource :records do
      desc "Post a single data line delimited by either pipes, commas, or spaces"
      post do
        begin
          parser = RecordParser.new(params[:line])
          parser.parse
          record = Record.new(last_name: parser.last_name, first_name: parser.first_name, gender: parser.gender, favorite_color: parser.favorite_color, date_of_birth: parser.date_of_birth)
        rescue
          error! "Invalid Record", 400
        end

        serialzer = RecordSerializer.new(record)
        File.open(get_record_filename, "a") do |file|
          file.puts(serialzer.to_s)
        end
        serialzer
      end

      desc "Return records sorted by gender (females before males) then by last name ascending."
      get :gender do
        RecordSetSerializer.new(get_current_record_set.sort_records_by_gender)
      end

      desc "Return records sorted by birth date, ascending."
      get :birthdate do
        RecordSetSerializer.new(get_current_record_set.sort_records_by_birth_date_ascending)
      end

      desc "Return records sorted by last name, descending."
      get :name do
        RecordSetSerializer.new(get_current_record_set.sort_records_by_last_name_descending)
      end
    end
  end
end