$:<< File.join(File.dirname(__FILE__), '..') #adds main directory to load path (for api)

require 'api'
require 'rack/test'
require 'json'

describe RecordParser::API do
  include Rack::Test::Methods

  def app
    RecordParser::API
  end

  def record_filename
    "records.txt"
  end

  before(:each) do
    File.delete(record_filename) if File.exists?(record_filename)
  end

  describe "POST /records" do
    context "when params[:line] is a valid record" do
      it "returns an HTTP 201 response" do
        post "/records", {"line" => "Smith Bob Male 10/12/1985 Blue"}
        expect(last_response.status).to eq(201)
      end

      it "returns respone with the json of the created record" do
        post "/records", {"line" => "Smith Bob Male 10/12/1985 Blue"}
        result = JSON.parse(last_response.body)

        expect(result.length).to eq(5)
        expect(result["last_name"]).to eq("Smith")
        expect(result["first_name"]).to eq("Bob")
        expect(result["gender"]).to eq("Male")
        expect(result["date_of_birth"]).to eq("10/12/1985")
        expect(result["favorite_color"]).to eq("Blue")
      end

      context "when the record file does not exist" do
        before(:each) do
          post "/records", {"line" => "Smith Bob Male 10/12/1985 Blue"}
        end

        it "creates the record file" do
          expect(File.exists?(record_filename)).to be_true
        end

        it "adds the record to the record file" do
          File.open(record_filename, "r") do |file|
            expect(file.grep("Smith Bob Male 10/12/1985 Blue")).to be_true
          end
        end
      end

      context "when the record file exists already" do
        before(:each) do
          File.open(record_filename, "w") do |file|
            file.puts "Smith Bob Male 10/12/1985 Blue"
          end
          post "/records", {"line" => "Jones Tom Male 10/12/1985 Blue"}
        end

        it "adds the record to the record file" do
          File.open(record_filename, "r") do |file|
            expect(file.grep("Jones Tom Male 10/12/1985 Blue")).to be_true
          end
        end

        it "does not delete the existing contents" do
          File.open(record_filename, "r") do |file|
            expect(file.grep("Smith Bob Male 10/12/1985 Blue")).to be_true
          end
        end
      end
    end

    context "when params[:line] is an invalid record" do
      before(:each) do
        post "/records", {"line" => "Smith Bob Male 10/12/1985"}        
      end
      it "returns an HTTP 400 response" do
        expect(last_response.status).to eq(400)
      end

      it "sends a response containing \"Invalid Record\"" do
        expect(last_response.body.include?("Invalid Record")).to be_true
      end

      it "does not make changes to the record file" do
        expect(File.exists?(record_filename)).to be_false
      end
    end
  end
end