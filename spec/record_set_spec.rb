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
      record.set_values_manually("Smith", "Bob", "male", "Blue", "5/15/1988")
      return record
    end

    let(:sarah_jones) do
      record = Record.new
      record.set_values_manually("Jones", "Sarah", "female", "Green", "1/2/1990")
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

    it "puts females before males and then sorts by last name ascending" do
      expect(records).to eq([sarah_jones, will_jones, bob_smith])
    end
  end

  describe "get_records_by_birth_date_ascending" do
    let(:first_person) do
      record = Record.new
      record.set_values_manually("Hamm", "Mia", "Female", "Blue", "5/15/1988")
      return record
    end

    let(:second_person) do
      record = Record.new
      record.set_values_manually("Smith", "Will", "Male", "Red", "1/3/1989")
      return record
    end

    let(:third_person) do
      record = Record.new
      record.set_values_manually("Williams", "Venus", "Female", "Green", "4/3/1989")
      return record
    end    

    let(:fourth_person) do
      record = Record.new
      record.set_values_manually("Gretzky", "Wayne", "Male", "Black", "6/13/1990")
      return record
    end    

    let(:fifth_person) do
      record = Record.new
      record.set_values_manually("Jordan", "Michael", "Male", "Brown", "5/14/1991")
      return record
    end    

    let(:records) do
      records = RecordSet.new
      records.add_records([fourth_person, second_person, first_person, fifth_person, third_person])
      records.get_records_by_birth_date_ascending
    end

    it "sorts everyone by ascending birth date" do
      expect(records).to eq([first_person, second_person, third_person, fourth_person, fifth_person])
    end
  end

  describe "get_records_by_last_name_descending" do
    let(:first_person) do
      record = Record.new
      record.set_values_manually("Gretzky", "Wayne", "Male", "Black", "6/13/1990")
      return record
    end

    let(:second_person) do
      record = Record.new
      record.set_values_manually("Hamm", "Mia", "Female", "Blue", "5/15/1988")
      return record
    end

    let(:third_person) do
      record = Record.new
      record.set_values_manually("jordan", "Michael", "Male", "Brown", "5/14/1991")
      return record
    end    

    let(:fourth_person) do
      record = Record.new
      record.set_values_manually("Smith", "Will", "Male", "Red", "1/3/1989")
      return record
    end

    let(:fifth_person) do
      record = Record.new
      record.set_values_manually("williams", "Venus", "Female", "Green", "4/3/1989")
      return record
    end

    let(:records) do
      records = RecordSet.new
      records.add_records([fourth_person, second_person, first_person, fifth_person, third_person])
      records.get_records_by_last_name_descending
    end

    it "sorts everyone by descending last name" do
      expect(records).to eq([fifth_person, fourth_person, third_person, second_person, first_person])
    end
  end
end