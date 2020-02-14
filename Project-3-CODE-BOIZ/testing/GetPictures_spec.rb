# File created 9/30/2019 by Zach Venables
#Edited on 10/5 by zach venables

require "mechanize"
require "nokogiri"

require 'rspec'
require_relative "../src/GetPictures.rb"
include GetPictures
describe "GetPictures" do
  it "gather faculty pictures" do
    agent = Mechanize.new
    page = agent.get("https://cse.osu.edu/about-us/faculty")

    #manually check the printed hash to verify that each instructor name corresponds with the title of the instructors photo found on the osu cse faculty page
    hash = GetPictures.get_instructor_pics page

    puts hash
    expect(hash.size).to eq(48)

  end

  it "gathers faculty websites" do
    agent = Mechanize.new
    page = agent.get("https://cse.osu.edu/about-us/faculty")

    #maunally check the printed has to verify that each instructor name corresponds with the title of the instructors link found on the osu cse faculty page
    hash =  GetPictures.get_instructor_website page

    puts hash
    expect(hash.size).to eq(48)
  end


  it "gathers instructors names" do
    agent = Mechanize.new
    page = agent.get("https://cse.osu.edu/about-us/faculty")

    #manually check the printed array has the correct instructor name the corresponds to the osu cse faculty website
    arr = GetPictures.get_instructor_names page

    puts arr
    expect(arr.size).to eq(48)
  end

end