#File created 9/29/19 By Sean Simpson
#Edited 10/4/19 by Sean Simpson
# Edited 10/6/2019 by Matthew Kelch - Fixed bugs that prevented email body from being sent, and helped send requests
require 'mechanize'
require 'nokogiri'
require_relative 'parseCourse.rb'
require 'mail'

URL = "https://cse.osu.edu//about-us/faculty"

#Class creation 9/29/19 by Sean Simpson
#Class creates an email based on course listings and sends to address
class Email
	#Setting the default settings for class to different settings for gmail
    settings = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'your.host.name',
            :user_name            => 'codeboiz3901',
            :password             => 'Temp3921',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }



	Mail.defaults do
		delivery_method :smtp, settings
	end

	#Created 9/29/19 by Sean Simpson
	#Edited 10/4/19 by Sean Simpson
	# Edited 10/6/2019 by Matthew Kelch - Fixed bug that prevented all instructors from being sent
	#Obtains the courses as an array and turns into a string body
	def self.obtain_course_listing request
		block_body = ""
		directory_page = Mechanize.new.get URL
		names = GetPictures.get_instructor_names directory_page
		names.each do |name|
			rawBody = request.getRequest name
			course_list = ParseCourse.parse(rawBody, name)
			course_list = Set.new course_list
			course_list = course_list.to_a
			unless course_list == []
				block_body += name.to_s + " is teaching " + course_list.to_s + "\n\n"
			end
		end
		block_body
	end

	#Created 9/29/19 by Sean Simpson
	#Edited 10/4/19 by Sean Simpson
	#Uses information extracted from course listing to mail to address
	def self.mail_info request, userAddress
		#Email verification check feature added 10/4/19
		while !userAddress.match?(/\A[\w.+-]+@\w+\.\w+(\.\w+)?\z/)
			puts "Error: #{userAddress} is an invalid address, enter again:"
			userAddress = gets.chomp
		end
		final_body = obtain_course_listing request
		Mail.deliver do
			from 'CODEBOIZProj3@gmail.com'
			to userAddress
			subject 'Requested course list information'
			body final_body
		end
	end
end