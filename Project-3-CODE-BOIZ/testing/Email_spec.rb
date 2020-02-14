#Created 10/4/19 by Sean Simpson
require 'rspec'
require 'mechanize'
require 'nokogiri'
require 'mail'
require_relative '../src/HTTPRequest'
require_relative '../src/Email'
require_relative '../src/parseCourse'

#Created 10/4/19 by Sean Simpson
describe 'Email' do

	#Created 10/4/19 by Sean Simpson
	it 'Checks a valid inputs for an email' do
	   userInput = "tacos@gmail.com"
	   userInput2 = "TaCosss23@gmail.com"
	   userInput3 = "simpson.691@buckeyemail.osu.edu"
	   expectedResult = "tacos@gmail.com"
	   expectedResult2 = "TaCosss23@gmail.com"
	   expectedResult3 = "simpson.691@buckeyemail.osu.edu"
	   trial = Email.new
	   userInput = trial.verify_name userInput
	   userInput2 = trial.verify_name userInput2
	   userInput3 = trial.verify_name userInput3
	   expect(userInput).to eq expectedResult
	   expect(userInput2).to eq expectedResult2
	   expect(userInput3).to eq expectedResult3
    end

end
