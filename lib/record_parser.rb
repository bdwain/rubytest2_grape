class RecordParser
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth

  def initialize(line)
    @line = line
  end

  def parse
    if(fields.length != 5) #invalid record
      raise "Invalid number of fields. Should be 5."
    end

    @last_name = fields[0]
    @first_name = fields[1]
    @gender = fields[2]
    @favorite_color = fields[favorite_color_index]
    @date_of_birth = fields[date_of_birth_index]
  end

  private
  def delimiter
    @delimiter ||= if @line.include? "|"
      " | "
    elsif @line.include? ","
      ", "
    else
      " "
    end
  end

  def fields
    @fields ||= @line.split(delimiter)
  end

  def favorite_color_index
    @color_index ||= if delimiter != " "
      3
    else
      4
    end
  end

  def date_of_birth_index
    @date_of_birth_index ||= if delimiter != " "
      4
    else
      3
    end
  end  
end
