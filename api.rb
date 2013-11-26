require 'file_parser'
require 'record_set'
require 'grape'

module RecordParser
  class API < Grape::API
    version 'v1', using: :path
    format :json

    helpers do
      def get_record_filename
        "records.txt"
      end

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

      end

      desc "Return records sorted by gender (females before males) then by last name ascending."
      get :gender do
        get_current_record_set.get_records_by_gender
      end

      desc "Return records sorted by birth date, ascending."
      get :birthdate do
        get_current_record_set.get_records_by_birth_date_ascending
      end

      desc "Return records sorted by last name, descending."
      get :name do
        get_current_record_set.get_records_by_last_name_descending
      end
    end
  end
end