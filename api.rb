require_relative 'lib/file_parser'
require_relative 'lib/record_set'

module RecordParser
  class API < Grape::API

    version 'v1', using: :path
    format :json

    helpers do
    end

    resource :records do
    end
  end
end