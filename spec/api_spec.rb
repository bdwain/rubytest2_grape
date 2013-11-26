$:<< File.join(File.dirname(__FILE__), '..') #adds main directory to load path

require 'api'
require 'rack/test'

describe RecordParser::API do
  include Rack::Test::Methods

  def app
    RecordParser::API
  end
end