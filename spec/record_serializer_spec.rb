require 'record_serializer'
require 'record'

describe RecordSerializer do
  describe "#to_s" do
    let(:serializer) {RecordSerializer.new(Record.new(last_name: "Smith", first_name: "Jon", gender: "Male", favorite_color: "Blue", date_of_birth: date))}
    let(:date) {"10/10/1988"}

    it "returns the fields separated by spaces" do
      expect(serializer.to_s).to eq("Smith Jon Male 10/10/1988 Blue" )
    end

    context "when the month is 1 digit long" do
      let(:date) {"1/10/1988"}
      it "doesn't zero-pad months" do
        result = serializer.to_s
        expect(result.include?(date)).to be_true
        expect(result.include?("0" + date)).to be_false
      end
    end

    context "when the day is 1 digit long" do
      let(:date) {"10/1/1988"}
      it "doesn't zero-pad days" do
        expect(serializer.to_s.include?(date)).to be_true
      end
    end
  end

  describe "#to_json" do
    let(:serializer) {RecordSerializer.new(Record.new(last_name: "Smith", first_name: "Jon", gender: "Male", favorite_color: "Blue", date_of_birth: date))}
    let(:date) {"5/15/1988"}

    it "returns a json representation of an object with the 5 fields" do
      result = JSON.parse(serializer.to_json)
      expect(result.length).to eq(5)
      expect(result["last_name"]).to eq("Smith")
      expect(result["first_name"]).to eq("Jon")
      expect(result["gender"]).to eq("Male")
      expect(result["favorite_color"]).to eq("Blue")
      expect(result["date_of_birth"]).to eq(date)
    end

    context "when the month is 1 digit long" do
      let(:date) {"1/10/1988"}
      it "doesn't zero-pad months" do
        result = serializer.to_json
        expect(result.include?(date)).to be_true
        expect(result.include?("0" + date)).to be_false
      end
    end

    context "when the day is 1 digit long" do
      let(:date) {"10/1/1988"}
      it "doesn't zero-pad days" do
        expect(serializer.to_json.include?(date)).to be_true
      end
    end    
  end
end