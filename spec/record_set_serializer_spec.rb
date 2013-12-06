require 'record_set_serializer'
require 'record_set'

describe RecordSetSerializer do
  describe "#to_json" do
    let(:record1) {Record.new(last_name: "Smith", first_name: "Bob", gender: "Male", favorite_color: "Blue", date_of_birth: "5/15/1988")}
    let(:record2) {Record.new(last_name: "Jones", first_name: "Tom", gender: "Male", favorite_color: "Green", date_of_birth: "1/2/1990")}
    let(:serializer) do
      set = RecordSet.new
      set.add_records([record1, record2])
      set.sort_records_by_last_name_descending
      RecordSetSerializer.new(set)
    end

    it "returns a json representation of a RecordSet" do
      result = JSON.parse(serializer.to_json)
      expect(result.length).to eq(2)
      expect(result[0]["last_name"]).to eq("Smith")
      expect(result[0]["first_name"]).to eq("Bob")
      expect(result[0]["gender"]).to eq("Male")
      expect(result[0]["favorite_color"]).to eq("Blue")
      expect(result[0]["date_of_birth"]).to eq("5/15/1988")
      expect(result[1]["last_name"]).to eq("Jones")
      expect(result[1]["first_name"]).to eq("Tom")
      expect(result[1]["gender"]).to eq("Male")
      expect(result[1]["favorite_color"]).to eq("Green")
      expect(result[1]["date_of_birth"]).to eq("1/2/1990")
    end
  end
end