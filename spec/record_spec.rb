require 'record'
require 'json'

describe Record do
  describe "#initialize" do
    context "when all fields are passed in" do
      let(:record) {Record.new(last_name: "Smith", first_name: "Jon", gender: "Male", favorite_color: "Blue", date_of_birth: date)}
      let(:date) {"5/15/1988"}

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
        let(:date) {Date.new(1988, 5, 15)}

        it "sets date_of_birth to the passed in value" do
          expect(record.date_of_birth).to eq(Date.new(1988, 5, 15))
        end
      end
    end

    context "when last_name is missing" do
      specify do
        expect{Record.new(first_name: "Jon", gender: "Male", 
          favorite_color: "Blue", date_of_birth: "5/15/1988")}.to raise_error("last_name is required")
      end
    end

    context "when first_name is missing" do
      specify do
        expect{Record.new(last_name: "Smith", gender: "Male", 
          favorite_color: "Blue", date_of_birth: "5/15/1988")}.to raise_error("first_name is required")
      end
    end

    context "when gender is missing" do
      specify do
        expect{Record.new(first_name: "Jon", last_name: "Smith", 
          favorite_color: "Blue", date_of_birth: "5/15/1988")}.to raise_error("gender is required")
      end
    end

    context "when favorite_color is missing" do
      specify do
        expect{Record.new(first_name: "Jon", gender: "Male", 
          last_name: "Smith", date_of_birth: "5/15/1988")}.to raise_error("favorite_color is required")
      end
    end

    context "when date_of_birth is missing" do
      specify do
        expect{Record.new(first_name: "Jon", gender: "Male", 
          favorite_color: "Blue", last_name: "Smith")}.to raise_error("date_of_birth is required")
      end
    end
  end  

  describe "#==" do
    let(:record1) {Record.new(last_name: "Jones", first_name: "Sarah", gender: "Female", favorite_color: "Green", date_of_birth: "3/2/1943")}

    context "when all fields are equal" do
      it "returns true" do
        record2 = Record.new(last_name: "Jones", first_name: "Sarah", gender: "Female", favorite_color: "Green", date_of_birth: "3/2/1943")
        expect(record1 == record2).to be_true
      end
    end

    context "when last_name is different" do
      it "returns false" do
        record2 = Record.new(last_name: "Smith", first_name: "Sarah", gender: "Female", favorite_color: "Green", date_of_birth: "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when first_name is different" do
      it "returns false" do
        record2 = Record.new(last_name: "Jones", first_name: "Annabel", gender: "Female", favorite_color: "Green", date_of_birth: "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when gender is different" do
      it "returns false" do
        record2 = Record.new(last_name: "Jones", first_name: "Sarah", gender: "Male", favorite_color: "Green", date_of_birth: "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when favorite_color is different" do
      it "returns false" do
        record2 = Record.new(last_name: "Jones", first_name: "Sarah", gender: "Female", favorite_color: "Red", date_of_birth: "3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when date_of_birth is different" do
      it "returns false" do
        record2 = Record.new(last_name: "Jones", first_name: "Sarah", gender: "Female", favorite_color: "Green", date_of_birth: "4/2/1943")
        expect(record1 == record2).to be_false
      end
    end    
  end
end