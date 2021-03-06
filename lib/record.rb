require 'date'

class Record
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth

  #ruby 2.1 should have required keyword args, so we won't need to explicity raise exceptions
  def initialize(last_name: nil, first_name: nil, gender: nil, favorite_color: nil, date_of_birth: nil)
    raise "last_name is required" unless @last_name = last_name
    raise "first_name is required" unless @first_name = first_name
    raise "gender is required" unless @gender = gender
    raise "favorite_color is required" unless @favorite_color = favorite_color

    raise "date_of_birth is required" unless date_of_birth

    if date_of_birth.is_a? Date
      @date_of_birth = date_of_birth
    else
      @date_of_birth = parse_date_string(date_of_birth)
    end
  end

  def ==(other_record)
    @last_name == other_record.last_name && 
    @first_name == other_record.first_name &&
    @gender == other_record.gender &&
    @favorite_color == other_record.favorite_color &&
    @date_of_birth == other_record.date_of_birth
  end

  private
  def parse_date_string(str)
    Date.strptime(str, "%m/%d/%Y")
  end
end