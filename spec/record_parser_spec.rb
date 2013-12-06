require 'record_parser'

describe RecordParser do
  describe "#parse" do
    let(:parser)  {RecordParser.new(line)}
    after(:each) do
      parser.parse
      expect(parser.last_name).to eq("Smith")
      expect(parser.first_name).to eq("Bob")
      expect(parser.gender).to eq("Male")
      expect(parser.favorite_color).to eq("Blue")
      expect(parser.date_of_birth).to eq("5/15/1988")
    end

    context "when input is pipe-delimited" do
      let(:line) {"Smith | Bob | Male | Blue | 5/15/1988"}
      it "populates all fields correctly" do
      end   
    end

    context "when input is comma-delimited" do
      let(:line) {"Smith, Bob, Male, Blue, 5/15/1988"}
      it "populates the fields correctly" do
      end           
    end

    context "when input is space-delimited" do
      let(:line) {"Smith Bob Male 5/15/1988 Blue"}
      it "populates the fields correctly" do
      end         
    end
  end  
end