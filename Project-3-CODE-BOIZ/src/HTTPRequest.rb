# File created on 9/29/2019 by Neil Mckibben, created initial get methods
# File edited on 10/6/2019 by Neil Mckibben - added classes, file IO, and all relavent methods
# File edited on 10/6/2019 by Matthew Kelch - change def of isClassOpen to be self, not instance method
# File edited on 10/6/2019 by Andrew Petrilli - changed isClassOpen back to instance method for stubbing purposes
#
require 'net/http'
require 'httparty'
# Created on 9/29/2019 by Neil Mckibben
# Updated 9/29/2019 by Neil Mckibben

VALID_CLASS_TERMS = ['A', 'S', '']
VALID_CLASS_OPENING = ['O', '']
#Query keys for when the classes are and what term
QUERY_KEYS = %w{term classPreference}
QUERY_VALUES = { "S" => "1202", "A" => "1198"}


class HTTPRequest
  attr_accessor :term
  attr_accessor :classPreference
  def initialize
    @term = nil
    @classPreference = nil
  end
=begin
  @param name : Name of instructor you want to find
  Returns an JSON string of page output
=end
  def getRequest name
      args = {
        "q"     => name,
        "subject" => "CSE",
        "campus"      => "COL",
        "p"   => "1",

      }
      #Handles user preferences individually
      unless @term == nil
        args["term"] = QUERY_VALUES[@term]
      end

      response = HTTParty.get('https://content.osu.edu/v2/classes/search', :query=>args)
      response.body
  end
=begin
  @classSection : Section number of class you want to check availability of
  @param courseID : Course number of class you want to check availability of
  @param courseOfferingNumber : Offering number of class you want to check availability of
  @param sessionCode : Session code of class (usually 1)
  @param termCode : Term of class
  Returns an JSON string of the class availability
=end
  def isClassOpen(classSection, courseId, courseOfferingNumber, sessionCode, termCode)
    args = {
      "classSection"     => classSection,
      "courseId" => courseId,
      "courseOfferingNumber"      => courseOfferingNumber,
      "sessionCode"   => sessionCode,
      "termCode" => termCode
    }
    response = HTTParty.get('https://content.osu.edu/v2/classes/availability', :query=>args)
    response.body
  end
=begin
  @returns an array of answers to the user state prompts. This allows us to apply
  additional parameters when querying
=end
  def getPrompts()
    answers = []
    #Prompt the user to choose their class preferences
    puts "Enter your class preferences, this preferences will be saved in the preferences.txt file:\n"
    #what time period
    term_period = "err"
    until VALID_CLASS_TERMS.include? term_period
      print "Do you have a class term preference? A(AU2019), S(SP2020), leave blank for no preference: "
      term_period = gets.chomp.upcase
    end
    answers.push(term_period)

    class_opening = "err"
    until VALID_CLASS_OPENING.include? class_opening
      print "Do you care if classes are open? O(Open), leave blank for no preference: "
      class_opening = gets.chomp.upcase
    end
    answers.push(class_opening)
  end
=begin
  Either sets the preferences of the user through terminal prompts, or reads in
  the preferences and set the instance variables accordingly.
=end
  def readFile()
    file_exists = File.file?("preferences.txt")
    if not file_exists
      file = File.open('preferences.txt', 'w')
      answers = getPrompts()
      answers.each_with_index do |answer, i|
        #Sets key values pairs in file
        unless answer == ''
          file.puts QUERY_KEYS[i] + ':' + answer
          puts QUERY_KEYS[i]
          case QUERY_KEYS[i]
          when QUERY_KEYS[0]
            @term = answer
          when QUERY_KEYS[1]
            @classPreference = answer
          end
        end
      end

    else
      #Reads in key values pairs if already written
      file = File.open('preferences.txt', 'r')
      file.each do |line|
        line = line.chomp
        values = line.split(':')
        case values[0]
        when QUERY_KEYS[0]
          @term = values[1]
        when QUERY_KEYS[1]
          @classPreference = values[1]
        end
      end
    end

  end
end
