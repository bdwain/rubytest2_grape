$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), "lib"))

require 'api'

run RecordParser::API