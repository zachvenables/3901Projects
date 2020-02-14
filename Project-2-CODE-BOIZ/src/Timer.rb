# File created 9/17/2019 by Zach Venables
# Edited on 9/17/2019 by Zach Venables
# Edited on 9/19/2019 by Neil Mckibben
#Edited on 9/20/2019 by Neil Mckibben
# Edited on 9/20/2019 by Andrew Petrilli

# Created 9/17/2019 by Zach Venables
require_relative "player"

class Timer

  # Created 9/17/2019 by Zach Venables
  # Getter/setter
  attr_accessor :time_entry
  attr_accessor :timer_string
  attr_accessor :computer_set

  # Created 9/17/2019 by Zach Venables
  # Constructor
  def initialize(time_entry)
    @time_entry = time_entry
    @timer_thread = nil
    #Added string variable --> since we are displaying on GUI terminal output isn't an option
    @timer_string = time_entry.to_s
    @computer_set = nil
  end

  # Created 9/17/2019 by Zach Venables
  # Creates a new thread to countdown while current process thread runs
  # Params player is part of Player class, remove 1 score if timer ends

  #Edited 9/20 by Neil Mckibben, added AI boolean to figure if we use the timer for ai or user
  # Edited on 9/20/2019 by Andrew Petrilli - made loop more ruby-like
  def start (player)
    @timer_thread = Thread.fork {
      #sleep @time_entry
      @time_entry.times do |i|
        sleep(1)
        #Changed 9/19 Neil Mckibben
        #Puts the value in string to print out to console
        @timer_string = (@time_entry - i).to_s
      end
      #Changed 9/19 Neil Mckibben
      #Puts the value in string to print out to console
      @timer_string = "TIME IS UP!!!  You lose 1 point. Continue to make your selection."
      player.score -= 1
      player.show_score
    }
  end

  # Created 9/20/2019 by Neil Mckibben
  # starts a timer. When the timer runs out, the computer will pick a set from the board
  def start_ai (player, computer, shoes)

    @timer_thread = Thread.fork {
      #sleep @time_entry
      @time_entry.times do
        sleep(1)
        #Changed 9/19 Neil Mckibben
        #Puts the value in string to print out to console
      end

      # Returns the set that the computer found
      @computer_set = computer.playMode shoes.board
    }
  end

  # Created 9/17/2019 by Zach Venables
  # kills the timer thread
  def stop
    @timer_thread.kill
    @timer_thread = nil
    @computer_set = nil
  end
end
