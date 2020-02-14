# File created 10/6/2019 by Neil Mckibben
#HTTPRequest_expected_output contains the files w/ the expected answers
require 'rspec'
require_relative "../src/HTTPRequest.rb"
require_relative "../src/parseCourse.rb"

describe "HTTPRequest" do
  it "query_info" do
    #Check the the courses outputted by the get request match the expected values
    test_query = HTTPRequest.new
    test_parse = ParseCourse.new
    name = 'wei'
    expected = File.read("HTTPRequest_expected_output/wei_query").chomp
    values = ParseCourse.parse(test_query.getRequest(name), name)
    actual = values.to_s
    expect(actual).to eq(expected)
  end
  it "query_info_two" do
    #Check the the courses outputted by the get request match the expected values
    test_query = HTTPRequest.new
    test_parse = ParseCourse.new
    name = 'Naeem'
    expected = File.read("HTTPRequest_expected_output/naeem_query").chomp
    values = ParseCourse.parse(test_query.getRequest(name), name)
    actual = values.to_s
    expect(actual).to eq(expected)
  end
  it "query_class_opening" do
    #Check that the class opening output matches with the expected value
    test_query = HTTPRequest.new
    expected = File.read("HTTPRequest_expected_output/class_opening_one").chomp
    actual = test_query.isClassOpen("0005", "150509", "1", "1", "1202")
    expect(actual).to eq(expected)
  end
  it "query_info_two" do
    #Check that the class opening output matches with the expected value
    test_query = HTTPRequest.new
    expected = File.read("HTTPRequest_expected_output/class_opening_two").chomp
    actual = test_query.isClassOpen("0010", "150546", "1", "1", "1202")
    expect(actual).to eq(expected)
  end
end
