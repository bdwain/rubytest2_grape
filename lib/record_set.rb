class RecordSet
  attr_reader :records

  def initialize(new_records = nil)
    if new_records
      @records = Array.new(new_records)
    else
      @records = Array.new
    end
  end

  def add_records(new_records)
    @records.concat(new_records)
    self
  end

  def sort_records_by_gender
    records.sort! do |r1, r2|
      if r1.gender.casecmp(r2.gender) == 0
        r1.last_name.casecmp(r2.last_name)
      else
        r1.gender.casecmp(r2.gender)
      end
    end
    self
  end

  def sort_records_by_birth_date_ascending
    records.sort! do |r1, r2|
      r1.date_of_birth <=> r2.date_of_birth
    end
    self
  end

  def sort_records_by_last_name_descending
    records.sort! do |r1, r2|
      r2.last_name.casecmp(r1.last_name)
    end
    self
  end
end