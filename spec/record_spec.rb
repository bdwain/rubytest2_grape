require 'record'
require 'json'

describe Record do
  describe "#valid?" do
    context "when @valid is true" do
      it "returns true" do
        record = Record.new
        record.instance_variable_set(:@valid, true)
        expect(record.valid?).to be_true
      end
    end

    context "when @valid is false" do
      it "returns false" do
        record = Record.new
        record.instance_variable_set(:@valid, false)
        expect(record.valid?).to be_false
      end
    end    
  end

  describe "#initialize" do
    let(:record) {Record.new("Smith", "Jon", "Male", "Blue", "5/15/1988")}

    it "sets last_name to the passed in value" do
      expect(record.last_name).to eq("Smith")
    end
    it "sets first_name to the passed in value" do
      expect(record.first_name).to eq("Jon")
    end
    it "sets gender to the passed in value" do
      expect(record.gender).to eq("Male")
    end
    it "sets favorite_color to the passed in value" do
      expect(record.favorite_color).to eq("Blue")
    end

    context "when date_of_birth is a String" do
      it "sets date_of_birth to a Date object parsed from the string" do
        expect(record.date_of_birth).to eq(Date.new(1988, 5, 15))
      end
    end

    context "when date_of_birth is a Date" do
      let(:date_record) {Record.new("Smith", "Jon", "Male", "Blue", Date.new(1988, 5, 15))}

      it "sets date_of_birth to the passed in value" do
        expect(date_record.date_of_birth).to eq(Date.new(1988, 5, 15))
      end
    end

    it "sets valid? to true" do
      expect(record.valid?).to be_true
    end
  end  

  describe "#==" do
    let(:record1) {Record.new("Jones", "Sarah", "Female", "Green", "3/2/1943")}

    context "when all fields are equal" do
      it "returns true" do
        record2 = Record.new("Jones", "Sarah", "Female", "Green", "3/2/1943")
        expect(record1 == record2).to be_true
      end
    end

    context "when last_name is different" do
      it "returns false" do
        record2 = Record.new("Smith", "Sarah", "Female", "Green", "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when first_name is different" do
      it "returns false" do
        record2 = Record.new("Jones", "Annabel", "Female", "Green", "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when gender is different" do
      it "returns false" do
        record2 = Record.new("Jones", "Sarah", "Male", "Green", "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when favorite_color is different" do
      it "returns false" do
        record2 = Record.new("Jones", "Sarah", "Female", "Red", "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when date_of_birth is different" do
      it "returns false" do
        record2 = Record.new("Jones", "Sarah", "Female", "Green", "4/2/1943")
        expect(record1 == record2).to be_false
      end
    end    
  end

  describe "#to_s" do
    context "when the record is valid" do
      let(:record) {Record.new("Smith", "Jon", "Male", "Blue", "10/10/1988")}

      it "returns the fields separated by spaces" do
        expect(record.to_s).to eq("Smith Jon Male 10/10/1988 Blue" )
      end

      it "doesn't zero-pad months" do
        record = Record.new("Smith", "Jon", "Male", "Blue", "1/10/1988")
        expect(record.to_s.include?("1/10/1988")).to be_true
      end

      it "doesn't zero-pad days" do
        record = Record.new("Smith", "Jon", "Male", "Blue", "10/1/1988")
        expect(record.to_s.include?("10/1/1988")).to be_true
      end
    end

    context "when the record is invalid" do
      let(:record) {Record.new}

      it "returns the fields separated by pipes" do
        expect(record.to_s).to eq("")
      end
    end
  end

  describe "#to_json" do
    context "when valid" do
      it "returns a json representation of an object with the 5 fields" do
        r = Record.new("Smith", "Jon", "Male", "Blue", "5/15/1988")
        result = JSON.parse(r.to_json)

        expect(result.length).to eq(5)
        expect(result["last_name"]).to eq("Smith")
        expect(result["first_name"]).to eq("Jon")
        expect(result["gender"]).to eq("Male")
        expect(result["favorite_color"]).to eq("Blue")
        expect(result["date_of_birth"]).to eq("5/15/1988")
      end
    end

    context "when invalid" do
      it "returns an empty string" do
        r = Record.new
        expect(r.to_json).to eq("")
      end
    end    
  end
end