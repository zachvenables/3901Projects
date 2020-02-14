# Created on 9/29/2019 by Matthew Kelch
# Edited on 10/5/2019 by Neil Mckibben - Refactored name of called method
# Edited on 10/6/2019 by Matthew Kelch - Refactored code to accommodate changes from other members
require "mechanize"
require "nokogiri"
require "erb"
require_relative "GetPictures.rb"
require_relative "parseCourse.rb"
require_relative "HTTPRequest.rb"

## This class takes the parsed professor data and combines is with the course data,
## outputting the combined data into an HTML file

# Declare constants to be used
ERB_FILENAME = "src/output.html.erb"
ERB_STRING = ".erb"
DIRECTORY_URL = "https://cse.osu.edu//about-us/faculty"

class Output
  include GetPictures

  # Created on 9/29/2019 by Matthew Kelch
  # Edited on 10/5/2019 by Neil Mckibben - Refactored name of called method
  # Edited on 10/6/2019 by Matthew Kelch - Now takes a HTMLRequest object as a parameter

  # Outputs a formatted html page based on the user's queries
  # @param request - An HTMLRequest object that contains the user's requested filter queries
  # @returns an HTML file named output.html that contains a table, where each table row contains:
  #    - a picture of a CSE professor from the DIRECTORY_URL webpage
  #    - the name of the corresponding professor, hyperlinked to their personal webpage (if available)
  #    - the courses the professor is teaching, based on the queries specified by the user. Each course is hyperlinked
  #             to its corresponding syllabus
  def self.output_html(request)
    # Use Mechanize to retrieve page to pass into get_instructor_pics
    directory_page = Mechanize.new.get DIRECTORY_URL

    # Scrape CSE directory, save images locally, and return a hash of {prof_name => image}
    @hashed_images = GetPictures.get_instructor_pics directory_page
    @hashed_images.delete nil

    # Scrape directory for the professor's website
    @hashed_sites = GetPictures.get_instructor_website directory_page
    @hashed_sites.delete nil

    # Merge the list of professor's images with their list of courses and their webpage (if they have one)
    @hashed_images.each_pair do |name, image|
      parsed_courses = ParseCourse.parse(request.getRequest(name), name)
      parsed_courses = Set.new parsed_courses
      parsed_courses = parsed_courses.to_a

      @hashed_images[name] = [image, parsed_courses, @hashed_sites[name]]
    end

    # Open the template and write to the HTML file
    # do end auto-closes the file after writing
    template = File.read ERB_FILENAME
    result = ERB.new(template).result binding
    File.open(File.basename(ERB_FILENAME, ERB_STRING), "w+") do |f|
      f.write result
    end
  end
end
