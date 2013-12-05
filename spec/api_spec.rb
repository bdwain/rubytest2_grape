$:<< File.join(File.dirname(__FILE__), '..') #adds main directory to load path (for api)

require 'api'
require 'rack/test'
require 'json'

describe RecordApi::API do
  include Rack::Test::Methods

  def app
    RecordApi::API
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

      it "can handle space delimited records" do
        post "/records", {"line" => "Smith Bob Male 10/12/1985 Blue"}
        expect(last_response.status).to eq(201)
      end

      it "can handle pipe delimited records" do
        post "/records", {"line" => "Smith | Bob | Male | Blue | 10/12/1985"}
        expect(last_response.status).to eq(201)
      end

      it "can handle comma delimited records" do
        post "/records", {"line" => "Smith, Bob, Male, Blue, 10/12/1985"}
        expect(last_response.status).to eq(201)
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

  describe "GET /records/gender" do
    context "when the records file exists" do
      before(:each) do
        File.open(record_filename, "w") do |file|
          file.puts "Smith Bob Male 10/12/1985 Blue"
          file.puts "Jones Sarah Female 12/12/1982 Blue"
          file.puts "Jones Tom Male 1/12/1984 Green"
          file.puts "Obama Michelle Female 1/13/1964 Red"
          file.puts "Obama Barack Male 8/4/1962 Blue"
        end
        get "/records/gender"
      end

      it "returns an HTTP 200 response" do
        expect(last_response.status).to eq(200)
      end

      it "returns the records sorted by gender (female first) and then last name ascending" do
        result = JSON.parse(last_response.body)
        expect(result.length).to eq(5)
        expect(result[0]["last_name"] == "Jones" && result[0]["first_name"] == "Sarah").to be_true
        expect(result[1]["last_name"] == "Obama" && result[1]["first_name"] == "Michelle").to be_true
        expect(result[2]["last_name"] == "Jones" && result[2]["first_name"] == "Tom").to be_true
        expect(result[3]["last_name"] == "Obama" && result[3]["first_name"] == "Barack").to be_true
        expect(result[4]["last_name"] == "Smith" && result[4]["first_name"] == "Bob").to be_true
      end
    end

    context "when the records file does not exist" do
      before(:each) do
        File.delete(record_filename) if File.exists?(record_filename)
        get "/records/gender"
      end

      it "returns an HTTP 200 response" do
        expect(last_response.status).to eq(200)
      end

      it "returns an empty json array" do
        expect(last_response.body).to eq("[]")
      end
    end
  end

  describe "GET /records/birthdate" do
    context "when the records file exists" do
      before(:each) do
        File.open(record_filename, "w") do |file|
          file.puts "Smith Bob Male 10/12/1985 Blue"
          file.puts "Jones Sarah Female 12/12/1982 Blue"
          file.puts "Jones Tom Male 1/12/1984 Green"
          file.puts "Obama Michelle Female 1/13/1964 Red"
          file.puts "Obama Barack Male 8/4/1962 Blue"
        end
        get "/records/birthdate"
      end

      it "returns an HTTP 200 response" do
        expect(last_response.status).to eq(200)
      end

      it "returns the records sorted by birth date ascending" do
        result = JSON.parse(last_response.body)
        expect(result.length).to eq(5)
        expect(result[0]["last_name"] == "Obama" && result[0]["first_name"] == "Barack").to be_true
        expect(result[1]["last_name"] == "Obama" && result[1]["first_name"] == "Michelle").to be_true
        expect(result[2]["last_name"] == "Jones" && result[2]["first_name"] == "Sarah").to be_true
        expect(result[3]["last_name"] == "Jones" && result[3]["first_name"] == "Tom").to be_true
        expect(result[4]["last_name"] == "Smith" && result[4]["first_name"] == "Bob").to be_true
      end
    end

    context "when the records file does not exist" do
      before(:each) do
        File.delete(record_filename) if File.exists?(record_filename)
        get "/records/birthdate"
      end

      it "returns an HTTP 200 response" do
        expect(last_response.status).to eq(200)
      end

      it "returns an empty json array" do
        expect(last_response.body).to eq("[]")
      end
    end    
  end

  describe "GET /records/name" do
    context "when the records file exists" do
      before(:each) do
        File.open(record_filename, "w") do |file|
          file.puts "Smith Bob Male 10/12/1985 Blue"
          file.puts "Jones Sarah Female 12/12/1982 Blue"
          file.puts "Walsh Tom Male 1/12/1984 Green"
          file.puts "Roosevelt Eleanor Female 1/13/1964 Red"
          file.puts "Washington George Male 2/4/1934 Blue"
        end
        get "/records/name"
      end

      it "returns an HTTP 200 response" do
        expect(last_response.status).to eq(200)
      end

      it "returns the records sorted by last name descending" do
        result = JSON.parse(last_response.body)
        expect(result.length).to eq(5)
        expect(result[0]["last_name"] == "Washington" && result[0]["first_name"] == "George").to be_true
        expect(result[1]["last_name"] == "Walsh" && result[1]["first_name"] == "Tom").to be_true
        expect(result[2]["last_name"] == "Smith" && result[2]["first_name"] == "Bob").to be_true
        expect(result[3]["last_name"] == "Roosevelt" && result[3]["first_name"] == "Eleanor").to be_true
        expect(result[4]["last_name"] == "Jones" && result[4]["first_name"] == "Sarah").to be_true
      end
    end

    context "when the records file does not exist" do
      before(:each) do
        File.delete(record_filename) if File.exists?(record_filename)
        get "/records/name"
      end

      it "returns an HTTP 200 response" do
        expect(last_response.status).to eq(200)
      end

      it "returns an empty json array" do
        expect(last_response.body).to eq("[]")
      end
    end       
  end
end