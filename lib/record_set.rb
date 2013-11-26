class RecordSet
  attr_reader :records

  def initialize
    @records = Array.new
  end

  def add_records(newRecords)
    @records.concat(newRecords.select {|record| record.valid? })
  end

  def get_records_by_gender
    records.sort do |r1, r2|
      if r1.gender == r2.gender
        r1.last_name <=> r2.last_name
      else
        r1.gender <=> r2.gender
      end
    end
  end

  def get_records_by_birth_date
    records.sort do |r1, r2|
      r1.date_of_birth <=> r2.date_of_birth
    end
  end

  def get_records_by_last_name_descending
    records.sort do |r1, r2|
      r2.last_name <=> r1.last_name
    end
  end
end