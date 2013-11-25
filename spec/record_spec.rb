require 'record'

describe Record do
  describe "parse" do
    let(:sample_record) do 
      sample_record = Record.new
      #instance_variable_set is used so the setter can be private
      sample_record.instance_variable_set(:@last_name, "Smith")
      sample_record.instance_variable_set(:@first_name, "Bob")
      sample_record.instance_variable_set(:@gender, "Male")
      sample_record.instance_variable_set(:@favorite_color, "Blue")
      sample_record.instance_variable_set(:@date_of_birth, Date.new(1988, 5, 15))
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
      record.parse("Smith Bob Male 5/15/1988 Blue")
      expect(record).to eq(sample_record)
    end
  end

  describe "==" do
    let(:record1) do
      sample_record = Record.new
      sample_record.parse("Jones | Sarah | Female | Green | 3/2/1943")
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
end