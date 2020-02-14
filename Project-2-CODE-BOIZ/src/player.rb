# File created 9/5/2019 by Zach Venables
# Edited 9/10/2019 by Zach Venables
# Edited 9/12/2019 by Matthew Kelch

#Created 9/17 by Zach Venables
class Player

    attr_reader :name
    attr_accessor :score

    # Created 9/5/2019 by Zach Venables
    # Constructor
    def initialize(name="NoEntry", score=0)
        #@name is a string that will represent the player's name
        # @score will be an int, will initially always be zero
        name = name.to_s
        if name.length == 0
            @name = "NoEntry"
        else
            @name = name
        end
        @score = score
    end

    # Created 9/5/2019 by Zach Venables
    # adds one to the player score
    def add_score
        @score += 1
    end

    # Created 9/12/2019 by Matthew Kelch
    # removes one from the player score
    def remove_score
        @score -= 1
    end

    # File created 9/5/2019 by Zach Venables
    # Prints player name and score to screen
    def show_score
        if @score == 1
            puts "\n#{@name} has #{@score} set"
        else
            puts"\n#{@name} has #{@score} sets \n"
        end
    end
end
