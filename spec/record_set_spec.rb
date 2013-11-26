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
end