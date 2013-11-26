class RecordSet
  attr_reader :records

  def initialize
    @records = Array.new
  end

  def AddRecords(newRecords)
    @records.concat(newRecords.select {|record| record.valid? })
  end

end