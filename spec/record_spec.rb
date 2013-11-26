require 'record'

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

  describe "#parse" do
    let(:sample_record) do 
      sample_record = Record.new
      sample_record.set_values_manually("Smith", "Bob", "Male", "Blue", "5/15/1988")
      return sample_record
    end
    let(:record)  {Record.new}

    context "when input is pipe-delimited" do
      it "populates all fields correctly" do
        record.parse("Smith | Bob | Male | Blue | 5/15/1988")
        expect(record).to eq(sample_record)
      end

      it "sets valid to true" do
        record.parse("Smith | Bob | Male | Blue | 5/15/1988")
        expect(record.valid?).to be_true
      end      
    end

    context "when input is comma-delimited" do
      it "populates the fields correctly" do
        record.parse("Smith, Bob, Male, Blue, 5/15/1988")
        expect(record).to eq(sample_record)
      end

      it "sets valid to true" do
        record.parse("Smith, Bob, Male, Blue, 5/15/1988")
        expect(record.valid?).to be_true
      end            
    end

    context "when input is space-delimited" do
      it "populates the fields correctly" do
        record.parse("Smith Bob Male 5/15/1988 Blue")
        expect(record).to eq(sample_record)
      end

      it "sets valid to true" do
        record.parse("Smith Bob Male 5/15/1988 Blue")
        expect(record.valid?).to be_true
      end            
    end
  end

  describe "==" do
    let(:record1) do
      sample_record = Record.new
      sample_record.set_values_manually("Jones", "Sarah", "Female", "Green", "3/2/1943")
      return sample_record
    end
    let(:record2) {Record.new}

    context "when all fields are equal" do
      context "when the delimiter is the same" do
        it "returns true" do
          record2.parse("Jones | Sarah | Female | Green | 3/2/1943")
          expect(record1 == record2).to be_true
        end
      end

      context "when the delimiter is different" do
        it "returns true" do
          record2.parse("Jones Sarah Female 3/2/1943 Green")
          expect(record1 == record2).to be_true
        end
      end      
    end

    context "when last_name is different" do
      it "returns false" do
        record2.parse("Smith | Sarah | Female | Green | 3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when first_name is different" do
      it "returns false" do
        record2.parse("Jones | Jon | Female | Green | 3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when gender is different" do
      it "returns false" do
        record2.parse("Jones | Sarah | Male | Green | 3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when favorite_color is different" do
      it "returns false" do
        record2.parse("Jones | Sarah | Female | Red | 3/2/1943")
        expect(record1 == record2).to be_false
      end
    end

    context "when date_of_birth is different" do
      it "returns false" do
        record2.parse("Smith | Sarah | Female | Green | 4/2/1943")
        expect(record1 == record2).to be_false
      end
    end    
  end

  describe "#to_s" do
    context "when the record is valid" do
      let(:record) do
        record = Record.new
        record.set_values_manually("Smith", "Jon", "Male", "Blue", "10/10/1988")
        return record
      end

      it "returns the fields separated by pipes" do
        expect(record.to_s).to eq("Smith | Jon | Male | Blue | 10/10/1988")
      end

      it "doesn't zero-pad months" do
        record.set_values_manually("Smith", "Jon", "Male", "Blue", "1/10/1988")
        expect(record.to_s.include?("1/10/1988")).to be_true
      end

      it "doesn't zero-pad days" do
        record.set_values_manually("Smith", "Jon", "Male", "Blue", "10/1/1988")
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

  describe "#set_values_manually" do
    let(:record) do
      record = Record.new
      record.set_values_manually("Smith", "Jon", "Male", "Blue", "5/15/1988")
      return record
    end

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
      let(:date_record) do
        record = Record.new
        record.set_values_manually("Smith", "Jon", "Male", "Blue", Date.new(1988, 5, 15))
        return record
      end

      it "sets date_of_birth to the passed in value" do
        expect(date_record.date_of_birth).to eq(Date.new(1988, 5, 15))
      end
    end

    it "sets valid? to true" do
      expect(record.valid?).to be_true
    end
  end
end