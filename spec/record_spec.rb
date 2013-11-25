require 'record'

describe Record do
  describe "parse" do
    let(:sample_record) do
      #instance_variable_set is used so the fields can be un-writable 
      sample_record = Record.new
      sample_record.instance_variable_set(:@last_name, "Smith")
      sample_record.instance_variable_set(:@first_name, "Bob")
      sample_record.instance_variable_set(:@gender, "Male")
      sample_record.instance_variable_set(:@favorite_color, "Blue")
      sample_record.instance_variable_set(:@date_of_birth, "5/15/1988")
      return sample_record
    end

    it "parses a line of pipe-delimited input" do
      record = Record.new
      record.parse("Smith | Bob | Male | Blue | 5/15/1988")
      expect(record).to eq(sample_record)
    end

    it "parses a line of comma-delimited input" do
      record = Record.new
      record.parse("Smith, Bob, Male, Blue, 5/15/1988")
      expect(record).to eq(sample_record)
    end

    it "parses a line of space-delimited input" do
      record = Record.new
      record.parse("Smith Bob Male Blue 5/15/1988")
      expect(record).to eq(sample_record)
    end
  end
end