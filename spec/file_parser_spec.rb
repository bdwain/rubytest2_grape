require 'file_parser'
require 'record'
require 'tempfile'

describe FileParser do
  describe "#parse_file" do
    context "when the file exists" do
      it "returns a set of records with the contents of the file" do
        file_parser = FileParser.new
        file = Tempfile.new('FileParser_parse_file_test')
        begin
          file.puts("Jones Sarah Female 4/1/1982 Red")
          file.puts("Smith Joe Male 5/15/1988 Blue")
          file.rewind
          result_set = file_parser.parse_file(file.path)
        ensure
          file.close
          file.unlink
        end

        record1 = Record.new(last_name: "Jones", first_name: "Sarah", gender: "Female", favorite_color: "Red", date_of_birth: "4/1/1982")
        record2 = Record.new(last_name: "Smith", first_name: "Joe", gender: "Male", favorite_color: "Blue", date_of_birth: "5/15/1988")

        expect(result_set.length).to eq(2)
        expect(result_set.include?(record1)).to be_true
        expect(result_set.include?(record2)).to be_true
      end
    end
  end

  context "when the file does not exist" do
    it "rescues the exception" do
      file_parser = FileParser.new
      expect {file_parser.parse_file("non_existant_file.bar")}.to_not raise_error
    end

    it "returns an empty array" do
      file_parser = FileParser.new
      expect(file_parser.parse_file("non_existant_file.bar")).to eq([])
    end
  end
end