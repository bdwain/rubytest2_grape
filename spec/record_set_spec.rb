require 'record_set'
require 'record'

describe RecordSet do
  describe "#add_records" do
    let(:records) do
      record1 = Record.new("Smith", "Bob", "Male", "Blue", "5/15/1988")
      record2 = Record.new("Jones", "Tom", "Male", "Green", "1/2/1990")
      [record1, record2]
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

  describe "#get_records_by_gender" do
    let(:bob_smith) do
      record = Record.new("Smith", "Bob", "male", "Blue", "5/15/1988")
    end

    let(:sarah_jones) {Record.new("Jones", "Sarah", "female", "Green", "1/2/1990")}
    let(:will_jones) {Record.new("Jones", "Will", "Male", "Red", "1/3/1945") }

    let(:records) do
      records = RecordSet.new
      records.add_records([bob_smith, sarah_jones, will_jones])
      records.get_records_by_gender
    end

    it "puts females before males and then sorts by last name ascending" do
      expect(records).to eq([sarah_jones, will_jones, bob_smith])
    end
  end

  describe "#get_records_by_birth_date_ascending" do
    let(:first_person) {Record.new("Hamm", "Mia", "Female", "Blue", "5/15/1988")}
    let(:second_person) {Record.new("Smith", "Will", "Male", "Red", "1/3/1989")}
    let(:third_person) {Record.new("Williams", "Venus", "Female", "Green", "4/3/1989")}
    let(:fourth_person) {Record.new("Gretzky", "Wayne", "Male", "Black", "6/13/1990")}
    let(:fifth_person) {Record.new("Jordan", "Michael", "Male", "Brown", "5/14/1991")}

    let(:records) do
      records = RecordSet.new
      records.add_records([fourth_person, second_person, first_person, fifth_person, third_person])
      records.get_records_by_birth_date_ascending
    end

    it "sorts everyone by ascending birth date" do
      expect(records).to eq([first_person, second_person, third_person, fourth_person, fifth_person])
    end
  end

  describe "#get_records_by_last_name_descending" do
    let(:first_person) {Record.new("Gretzky", "Wayne", "Male", "Black", "6/13/1990")}    
    let(:second_person) {Record.new("Hamm", "Mia", "Female", "Blue", "5/15/1988")}
    let(:third_person) {Record.new("Jordan", "Michael", "Male", "Brown", "5/14/1991")}
    let(:fourth_person) {Record.new("Smith", "Will", "Male", "Red", "1/3/1989")}
    let(:fifth_person) {Record.new("Williams", "Venus", "Female", "Green", "4/3/1989")}

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