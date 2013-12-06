class RecordSerializer
  def initialize(record)
    @record = record
  end

  def to_s
    "#{@record.last_name} #{@record.first_name} #{@record.gender} #{get_date_string(@record.date_of_birth)} #{@record.favorite_color}"
  end

  def to_json(options = nil)
    {"last_name" => @record.last_name, "first_name" => @record.first_name, "gender" => @record.gender, 
     "favorite_color" => @record.favorite_color, "date_of_birth" => get_date_string(@record.date_of_birth)}.to_json
  end

  private
  def get_date_string(date)
    date.strftime("%-m/%-d/%Y")
  end
end