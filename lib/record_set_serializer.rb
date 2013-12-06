require 'record_serializer'
require 'json'

class RecordSetSerializer
  def initialize(record_set)
    @record_set = record_set
  end

  def to_json(options = nil)
    @record_set.records.map { |record| RecordSerializer.new(record) }.to_json(options)
  end
end