class Record
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth
  
  def valid?
    @valid
  end

  def parse(line)
    if line.include? "|"
      delimiter = " | "
    elsif line.include? ","
      delimiter = ", "
    else
      delimiter = " "
    end

    fields = line.split(delimiter)
    if(fields.length != 5) #invalid record
      return
    end

    @last_name = fields[0]
    @first_name = fields[1]
    @gender = fields[2]

    if delimiter != " "
      @favorite_color = fields[3]
      @date_of_birth = Date.strptime(fields[4], "%m/%d/%Y")
    else
      @favorite_color = fields[4]
      @date_of_birth = Date.strptime(fields[3], "%m/%d/%Y")
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

  def set_values_manually(last_name, first_name, gender, favorite_color, date_of_birth)
    @last_name = last_name
    @first_name = first_name
    @gender = gender
    @favorite_color = favorite_color

    if date_of_birth.is_a? Date
      @date_of_birth = date_of_birth
    else
      @date_of_birth = Date.strptime(date_of_birth, "%m/%d/%Y")
    end

    @valid = true
  end
end