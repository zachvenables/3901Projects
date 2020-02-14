# File created on 9/29/2019 by Andrew Petrilli
# Edited on 9/30/2019 by Matthew Kelch - Changed get_courses to verify that a given professor is actually teaching a given course
# Edited on 10/04/2019 by Andrew Petrilli - Fixed variable names to conform to snake case convention
# Edited on 10/05/2019 by Andrew Petrilli - Added functionality to get open sections for courses
# Edited on 10/6/2019 by Matthew Kelch - Verify first 2 letters of first name of a professor
# Edited on 10/06/2019 by Andrew Petrilli - changed how isClassOpen is called

# ParseCourse class that parses raw data returned from http calls

require "json"
require_relative "HTTPRequest.rb"

# Declare constants
CSE = "CSE"

# Created on 9/29/2019 by Andrew Petrilli
class ParseCourse
  # Created on 9/29/2019 by Andrew Petrilli
  # Edited on 10/05/2019 by Andrew Petrilli
=begin
  @param raw_body : String of json formatted text
  @param name : name of professor we are looking for, i.e
    only courses taught by #name will be returned
  @returns an array of course names described within raw_body
=end
  def self.parse(raw_body, name)
    parsed_body = JSON.parse(raw_body)
    parsed_data = parsed_body["data"]
    get_courses(parsed_data, name)
  end

  # Created on 10/05/2019 by Andrew Petrilli
=begin
  @param raw_body : String of json formatted text
  @returns a hash, h. For each key k, where k is the course number,
    h[k] = array of sections that are designated as open. If a course
    has no open sections then it is not added to the hash, so if, say,
    3901 had no open sections, then h[3901] = nil.
=end
  def self.get_open_courses(raw_body)
    parsed_body = JSON.parse(raw_body)
    parsed_data = parsed_body["data"]
    

    open_courses = Hash.new
    parsed_data["courses"].each do |course|
      open_sections = []
      course["sections"].each do |section|
        class_section = section["section"]
        course_id = section["courseId"]
        course_offering_number = section["courseOfferingNumber"]
        session_code = section["sessionCode"]
        term_code = section["termCode"]
        parsed_response = JSON.parse HTTPRequest.new.isClassOpen class_section, course_id, course_offering_number, session_code, term_code
        is_open = parsed_response["data"]["availability"]["isOpen"]
        open_sections << section["section"] if is_open
      end
      open_courses[course["course"]["catalogNumber"]] = open_sections unless open_sections.length == 0
    end
    open_courses
  end

  # Created on 9/29/2019 by Andrew Petrilli
  # Edited on 9/30/2019 by Matthew Kelch - Improved verification of whether a prof is actually teaching a course
=begin
  @param parsed_data : JSON Object
  @param name : name of professor we are looking for, i.e
    only courses taught by #name will be returned
  @returns an array of course names in the form of:
    CSE {Course Number}: {Course Name}
=end
  def self.get_courses(parsed_data, name)
    courses = []
    parsed_data["courses"].each do |course|
      # Check if the professor with @param name is teaching course
      teaches_class = false
      instructor_list = course["sections"][0]["meetings"][0]["instructors"]
      course_data = course["course"]
      is_cse = course_data["subject"] == CSE

      instructor_list.each do |instructor|
        instructor_name = instructor["displayName"]
        unless instructor_name.nil?
          # Check last name and first 2 letters of first names
          # Checking full first names is difficult because they differ between sources (e.g. Paul vs. Paolo Sivilotti)
          teaches_class = false
          unless name == ""
            teaches_class = instructor_name.include? name.split[0][0,2]
            teaches_class = teaches_class && instructor_name.include?(name.split[-1])
          end
        end
        break if teaches_class
      end

      # Only append to output when a professor teaches a given course
      if teaches_class && is_cse
        course_name = course_data["title"]
        course_number = course_data["catalogNumber"]
        courses << CSE + " " + course_number + ": " + course_name
      end
    end
    courses
  end
end
