class RecordParser
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth

  def initialize(line)
    @line = line
  end

  def parse
    if @line.include? "|"
      delimiter = " | "
    elsif @line.include? ","
      delimiter = ", "
    else
      delimiter = " "
    end

    fields = @line.split(delimiter)
    if(fields.length != 5) #invalid record
      return
    end

    @last_name = fields[0]
    @first_name = fields[1]
    @gender = fields[2]

    if delimiter != " "
      @favorite_color = fields[3]
      @date_of_birth = fields[4]
    else
      @favorite_color = fields[4]
      @date_of_birth = fields[3]
    end
  end
end
