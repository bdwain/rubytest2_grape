class RecordSet
  attr_reader :records

  def initialize
    @records = Array.new
  end

  def add_records(newRecords)
    @records.concat(newRecords.select {|record| record.valid? })
  end

end