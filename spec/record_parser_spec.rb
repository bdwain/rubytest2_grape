require 'record_parser'

describe RecordParser do
  describe "#parse" do
    let(:parser)  {RecordParser.new}
    after(:each) do
      expect(parser.last_name).to eq("Smith")
      expect(parser.first_name).to eq("Bob")
      expect(parser.gender).to eq("Male")
      expect(parser.favorite_color).to eq("Blue")
      expect(parser.date_of_birth).to eq("5/15/1988")
    end

    context "when input is pipe-delimited" do
      it "populates all fields correctly" do
        parser.parse("Smith | Bob | Male | Blue | 5/15/1988")
      end   
    end

    context "when input is comma-delimited" do
      it "populates the fields correctly" do
        parser.parse("Smith, Bob, Male, Blue, 5/15/1988")
      end           
    end

    context "when input is space-delimited" do
      it "populates the fields correctly" do
        parser.parse("Smith Bob Male 5/15/1988 Blue")
      end         
    end
  end  
end