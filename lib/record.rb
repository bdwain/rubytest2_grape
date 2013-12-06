require 'date'

class Record
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth
  
  def valid?
    @valid
  end

  def initialize(last_name = nil, first_name = nil, gender = nil, favorite_color = nil, date_of_birth = nil)
    if(last_name == nil)
      return
    end

    @last_name = last_name
    @first_name = first_name
    @gender = gender
    @favorite_color = favorite_color

    if date_of_birth.is_a? Date
      @date_of_birth = date_of_birth
    else
      @date_of_birth = parse_date_string(date_of_birth)
    end

    @valid = true
  end

  def ==(other_record)
    @last_name == other_record.last_name && 
    @first_name == other_record.first_name &&
    @gender == other_record.gender &&
    @favorite_color == other_record.favorite_color &&
    @date_of_birth == other_record.date_of_birth &&
    @valid == other_record.valid?
  end

  def to_s
    if valid?
      "#{@last_name} #{@first_name} #{@gender} #{get_date_string(@date_of_birth)} #{@favorite_color}"
    else
      ""
    end
  end

  def to_json(options = nil)
    if !valid?
      return ""
    end
    result = "{\"last_name\" : \"#{@last_name}\", \"first_name\" : \"#{@first_name}\","
    result << "\"gender\" : \"#{@gender}\", \"favorite_color\" : \"#{@favorite_color}\", "
    result << "\"date_of_birth\" : \"#{get_date_string(@date_of_birth)}\"}"
  end

  private
  def parse_date_string(str)
    Date.strptime(str, "%m/%d/%Y")
  end

  def get_date_string(date)
    date.strftime("%-m/%-d/%Y")
  end
end