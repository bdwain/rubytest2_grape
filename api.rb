require_relative 'lib/file_parser'
require_relative 'lib/record_set'

module RecordParser
  class API < Grape::API
    version 'v1', using: :path
    format :json

    helpers do
    end

    resource :records do
      desc "Post a single data line delimited by either pipes, commas, or spaces"
      post do

      end

      desc "Return records sorted by gender (females before males) then by last name ascending."
      get :gender do

      end

      desc "Return records sorted by birth date, ascending."
      get :birthdate do

      end

      desc "Return records sorted by last name, descending."
      get :name do

      end
    end
  end
end