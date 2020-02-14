#File created 9/17/19 by Sean Simpson
#Computer player for the set game.  Uses random number generator
#to automatically pick a set 100% correctly, or choose random
#three cards.

class Computer
	#Created 9/17/19 by Sean Simpson
	#Edited 9/19/19 by Sean Simpson
	#constructor takes in the difficulty selection for computer
	def initialize(difficulty)
		@difficulty = difficulty
		@score = 0
	end

	#Created 9/17/19 by Sean Simpson
	#Edited 9/19/19 by Sean Simpson
	#Difficulty changes accuracy for computer selection, selects cards
	def playMode(board)
		accuracy = rand(100) #value for 100% correctly choosing set
		case @difficulty
		when 1
			if (0..50) === accuracy #50% chance to pick 100% correct
				@setChoice = board.find_set
			else #Random selection if lower probability succeeds
				randomSelection(board)
			end
		when 2
			if (0..70) === accuracy #70% chance to pick 100% correct
				@setChoice = board.find_set
			else #Random selection if lower probability succeeds
				randomSelection(board)
			end
		when 3
			if (0..85) === accuracy #85% chance to pick 100% correct
				@setChoice = board.find_set
			else #Random selection if lower probability succeeds
				randomSelection(board)
			end
		end
		return @setChoice
	end

	#Created 9/19/19 by Sean Simpson
	#Deducts or adds a point to instance score depending on choice
	def scoreAccum(result)
		if result == 1
			@score += 1
		else
			@score -= 1
		end
	end

	#Created 9/19/19 by Sean Simpson
	#Generates a random selection of three cards for the computer
	private
	def randomSelection(board)
		combos = board.state.combination(3).to_a
		@setChoice = combos.sample
		while @setChoice.include? nil #combo checks for nil
				@setChoice = combos.sample
		end
	end
end