# File created 9/7/19 by Sean Simpson
# Edited 9/12/2019 by Matthew Kelch - Fixed bugs in Validity logic
# Edited 9/19/19 by Sean Simpson - Undid some fix changes in logic, made more terse

class Logic
	#Created 9/7/19 by Sean Simpson
	#constructor takes in the selection of cards for set
	def initialize(cardOne,cardTwo,cardThree)
		@hand = [cardOne,cardTwo,cardThree]
	end

	#Created 9/7/19 by Sean Simpson
	#Based on validity of a set, returns a score accum based on result
	def verifySet
		score = -1 #-1 given to user for invalid set
		if numberValid && colorValid && fillValid && shapeValid
			score = 1
		end
		return score
	end

    #Created 9/7/19 by Sean Simpson
    #Edited 9/19/19 by Sean Simpson
    #check if number is all equal or different
	def numberValid
		(@hand[0].number == @hand[1].number && @hand[0].number == @hand[2].number) ||
		(@hand[0].number != @hand[1].number && @hand[0].number != @hand[2].number && @hand[1].number != @hand[2].number)
	end

    #Created 9/7/19 by Sean Simpson
    #Edited 9/19/19 by Sean Simpson
    #check if color is all equal or different
	def colorValid
		(@hand[0].color == @hand[1].color && @hand[0].color == @hand[2].color) ||
		(@hand[0].color != @hand[1].color && @hand[0].color != @hand[2].color && @hand[1].color != @hand[2].color)
	end

    #Created 9/7/19 by Sean Simpson
    #Edited 9/19/19 by Sean Simpson
    #check if fill is all equal or different
	def fillValid
		(@hand[0].fill == @hand[1].fill && @hand[0].fill == @hand[2].fill) ||
		(@hand[0].fill != @hand[1].fill && @hand[0].fill != @hand[2].fill && @hand[1].fill != @hand[2].fill)
	end

    #Created 9/7/19 by Sean Simpson
    #Edited 9/19/19 by Sean Simpson
    #check if shape is all equal or different
	def shapeValid
		(@hand[0].shape == @hand[1].shape && @hand[0].shape == @hand[2].shape) ||
		(@hand[0].shape != @hand[1].shape && @hand[0].shape != @hand[2].shape && @hand[1].shape != @hand[2].shape)
	end
end