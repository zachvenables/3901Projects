# Created on 10/6/2019 by Matthew Kelch
require_relative 'src/Output.rb'
require_relative 'src/Email.rb'
require_relative 'src/HTTPRequest.rb'

# This file runs all of the code to:
#  - ask a user for their search preferences
#  - scrape the CSE faculty page for information
#  - output the information into an HTML file
#  - email the information to the user

PROMPT_USER_EMAIL = "\n\nIf you would like to be emailed a course listing, please enter your valid email address.\nOtherwise, leave this field blank: "

request = HTTPRequest.new

# Gather query information from user
request.readFile

Output.output_html request

puts PROMPT_USER_EMAIL
email = gets.chomp!

Email.mail_info(request, email) unless email.empty?