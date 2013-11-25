class Record
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth
  
  def parse(line)
    if line.include? "|"
      delimiter = " | "
    elsif line.include? ","
      delimiter = ", "
    else
      delimiter = " "
    end

    fields = line.split(delimiter)
    @last_name = fields[0]
    @first_name = fields[1]
    @gender = fields[2]
    @favorite_color = fields[3]
    @date_of_birth = fields[4]
  end

  def ==(other_record)
    @last_name == other_record.last_name && 
    @first_name == other_record.first_name &&
    @gender == other_record.gender &&
    @favorite_color == other_record.favorite_color &&
    @date_of_birth == other_record.date_of_birth
  end
end