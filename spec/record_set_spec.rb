require 'record_set'
require 'record'

describe RecordSet do
  describe "add_records" do
    let(:records) do
      record1 = Record.new
      record1.set_values_manually("Smith", "Bob", "Male", "Blue", "5/15/1988")
      record2 = Record.new
      record2.set_values_manually("Jones", "Tom", "Male", "Green", "1/2/1990")
      return [record1, record2]
    end

    let(:set) {RecordSet.new}

    it "Adds the passed in records to the set" do
      set.add_records(records)

      expect(set.records.size).to eq(2)
      expect(set.records.include?(records[0])).to be_true
      expect(set.records.include?(records[1])).to be_true
    end

    it "Doesn't add invalid records to the set" do
      record3 = Record.new
      records.push(record3)

      set.add_records(records)
      expect(set.records.include?(record3)).to be_false
    end
  end

  describe "get_records_by_gender" do
    let(:bob_smith) do
      record = Record.new
      record.set_values_manually("Smith", "Bob", "Male", "Blue", "5/15/1988")
      return record
    end

    let(:sarah_jones) do
      record = Record.new
      record.set_values_manually("Jones", "Sarah", "Female", "Green", "1/2/1990")
      return record
    end

    let(:will_jones) do
      record = Record.new
      record.set_values_manually("Jones", "Will", "Male", "Red", "1/3/1945")
      return record
    end    

    let(:records) do
      records = RecordSet.new
      records.add_records([bob_smith, sarah_jones, will_jones])
      records.get_records_by_gender
    end

    it "returns an array with all of the added records" do
      expect(records.length).to eq(3)
      expect(records.include?(bob_smith)).to be_true
      expect(records.include?(sarah_jones)).to be_true
      expect(records.include?(will_jones)).to be_true
    end

    it "puts females before males in the results" do
      expect(records[0]).to eq(sarah_jones)
    end

    it "sorts by last name ascending when the gender is the same" do
      expect(records[1]).to eq(will_jones)
    end
  end

  describe "get_records_by_birth_date" do
    let(:young_person) do
      record = Record.new
      record.set_values_manually("Smith", "Bob", "Male", "Blue", "5/15/1988")
      return record
    end

    let(:old_person) do
      record = Record.new
      record.set_values_manually("Jones", "Will", "Male", "Red", "1/3/1945")
      return record
    end    

    let(:records) do
      records = RecordSet.new
      records.add_records([young_person, old_person])
      records.get_records_by_birth_date
    end

    it "returns an array with all of the added records" do
      expect(records.length).to eq(2)
      expect(records.include?(old_person)).to be_true
      expect(records.include?(young_person)).to be_true
    end

    it "puts the earlier dates of birth first" do
      expect(records[0]).to eq(old_person)
    end
  end
end