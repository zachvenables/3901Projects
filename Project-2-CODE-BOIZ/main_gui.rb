# File created 9/11/2019 by Matthew Kelch
# File edited 9/12/2019 by Matthew Kelch
# File edited 9/17/2019 by Matthew Kelch
# File edited 9/18/2019 by Matthew Kelch
# File edited 9/18/2019 by Zach Venables
# File edited 9/19/2019 by Andrew Petrilli - documentation
#File edited 9/19/2019 by Neil Mckibben
# File edited 9/20/2019 by Matthew Kelch - Bugfixes to AI

require_relative "src/player"
require_relative "src/Board"
require_relative "src/Card"
require_relative "src/Logic"
require_relative "src/Deck"
require_relative "src/Hint_Generator"
require_relative "src/Timer" #Integrated timer into the GUI
require_relative "src/Computer"

ROW_INDEX_RANGES = [(0..3), (4..7), (8..11), (12..15), (16..19)]
MAX_BOARD_SIZE = 20

BLANK_IMAGE_FILEPATH = "assets/blank.png"
IMAGE_FILEPATH = "assets/%s.png"

ALERT_GAME_GREETING = "Welcome to CODE BOIZ Set Game!\nPlease enter your name:"
ALERT_MORE_CARDS = "Adding more cards because no set is on board!"
ALERT_SET_FOUND = "That's a set!"
ALERT_AI_SET_FOUND = "AI found a set!"
ALERT_NOT_A_SET = "Not a set!"
ALERT_AI_NOT_A_SET = "AI chose an incorrect set!"
ALERT_THREE_DIFF = "Please click on 3 different cards."
ALERT_GET_DIFFICULTY = "Please select your difficulty!\n\nEnter 1 for Easy\n2 for Medium\n3 for Hard"
ALERT_AI = "Do you want to play against the AI? Enter Yes/No"
# Pass in [player.name, player.score, ai_player.name, ai_player.score, <winner of game>.name]
ALERT_ENDGAME = "Game over, %s. You scored %s points!"
ALERT_AI_ENDGAME = "Game over, %s. You scored %s points!\n%s scored %s points!\n%s wins!"
ALERT_AI_ENDGAME_TIE = "Game over, %s. You scored %s points!\n%s scored %s points!\nIt's a tie!"
AI = "AI"

HINT_BUTTONS = {1 => "the number of sets on the board",
                2 => "a card that is part of a set",
                3 => "2 cards that are part of a set",
                4 => "a complete set"}


#String values for difficulty
DIFFICULTY_STRING = %w(1 2 3)
AI_ANSWERS = %w(Yes No)
TIMER_STRING = [120, 60, 30]

# Created by Matthew Kelch
# Updates board UI to match the board state, and returns an array of the image references
def update_board_ui
  # Add hint buttons to the gui
  flow do
    @buttons.each_index do |i|
      @buttons[i].remove unless @buttons[i].nil?
      @buttons[i] = button HINT_BUTTONS[i+1]
      @buttons[i].click { alert Hint.give_hint i+1, @board }
    end
  end

  @imgs = Array.new @board.state.size

  # Creates spaces for up to 5 rows of 4 cards (can be changed via row_index_ranges)
  ROW_INDEX_RANGES.each do |range|
    flow do
      range.each do |i|
        card_i = @board.state[i]
        if card_i.nil?
          @imgs[i] = image BLANK_IMAGE_FILEPATH
        else
          @imgs[i] = image IMAGE_FILEPATH % card_i.img_num
        end
      end
    end
  end
end

def trigger_endgame
  if @ai_on
    if @player.score == @ai_player.score
      alert ALERT_AI_ENDGAME_TIE % [@player.name, @player.score, @ai_player.name, @ai_player.score]
    else
      winner = @player.score > @ai_player.score ? @player.name : @ai_player.name
      alert ALERT_AI_ENDGAME % [@player.name, @player.score, @ai_player.name, @ai_player.score, winner]
    end
  else
    alert ALERT_ENDGAME % [@player.name, @player.score]
  end
  exit
end

# Edited 9/20/2019 by Matthew Kelch
# Collects clicks from user
def wait_for_input
  @imgs.each_index do |i|
    @imgs[i].click do
      @clicked_imgs.push i
      verify_human_set if @clicked_imgs.size == 3
    end
  end
end

# Edited 9/20/2019 by Matthew Kelch
# Adds additional cards to the board when there's no available set
def add_more_if_needed
  while @board.find_set == nil && @deck.size > 0 do
    alert ALERT_MORE_CARDS
    @board.add [@deck.removeCard, @deck.removeCard, @deck.removeCard]
  end
end

# Contains core game logic, including set verification and card removal/addition for the human player
def verify_human_set
  set = [@board.state[@clicked_imgs[0]], @board.state[@clicked_imgs[1]], @board.state[@clicked_imgs[2]]]

  # Proceed with verification if cards aren't nil and are each unique
  if (!set[0].nil? && !set[1].nil? && !set[2].nil?) && (set[0] != set[1] && set[0] != set[2] && set[1] != set[2])
    if Logic.new(*set).verifySet == 1
      # If there's a set, then: add score, remove the set, add multiples of 3 cards until a new set is possible,
      #     update board ui, then continue with game or proceed to endgame if conditions are met
      @timer_inst.stop

      @player.add_score

      alert ALERT_SET_FOUND

      if @ai_on
        @timer_inst.start_ai @player,@computer, self
      else
        @timer_inst.start @player
      end

      @board.remove set

      # Don't add cards if either the deck is empty OR if the board still has 12+ cards after removing the last set
      if @board.size < 12 && @deck.size > 0
        @board.add [@deck.removeCard, @deck.removeCard, @deck.removeCard]
      end

      # Adds more cards if we don't have a set
      add_more_if_needed

      # Clears existing board ui before updating
      @imgs.each do |img|
        img.remove
      end

      update_board_ui

      trigger_endgame if @deck.size == 0 && @board.find_set == nil
    else
      # Then we don't have a set, so penalize player
      @player.remove_score
      alert ALERT_NOT_A_SET
    end
  else
    # In this case, user either clicked on the same card >1 time, or clicked on an empty space
    alert ALERT_THREE_DIFF
  end

  # Clear input
  @clicked_imgs.clear

  wait_for_input
end

Shoes.app do

  #edited 9/18 by zach venables
  #edited 9/19 by Neil Mckibben

  # Allows board to be accessed from other classes
  def board
    return @board
  end

  # Initialize our hint button container
  @buttons = Array.new HINT_BUTTONS.length

  #Integer is used as reference to the difficulty selected
  @difficulty
  @player_state = para ""
  @timer = para ""
  @ai_state = para ""
  @clicked_imgs = []


  # Initialize game state

  #Updated 9/19 by Neil Mckibben
  # Asks the name from the player
  name = ""
  while name.length == 0
      name = ask ALERT_GAME_GREETING
      if name == nil
          exit #Exit bc the user hit cancel
      end
      @player = Player.new name, 0
  end

  #Edited by zach Venables 9/20
  # Asks the player whether they would like to play against the computer
  ai_choice = ""
  until AI_ANSWERS.include? ai_choice
      ai_choice = ask ALERT_AI
      if ai_choice.nil?
          exit
      end
      ai_choice.capitalize!
  end

  #Created 9/19 by Neil Mckibben
  #Forces the user in a loop until the enter a valid difficulty
  #Edited 9/20 by Zach Venables
  until DIFFICULTY_STRING.include? @difficulty
      @difficulty = ask ALERT_GET_DIFFICULTY
      if @difficulty.nil?
          exit #Exit bc the user hit cancel
      end
      @difficulty.capitalize!
  end
  @difficulty = @difficulty.to_i

  # Edited 9/18.2019 by Zach Venables
  # Initialize the deck and board
  @deck = Deck.new
  hand = Array.new
  12.times {hand.push @deck.removeCard}

  # Pad out board with nil to match MAX_BOARD_SIZE
  hand[MAX_BOARD_SIZE-1] = nil
  @board = Board.new hand

  add_more_if_needed

  #Initialize timer and player name
  @timer_inst = Timer.new TIMER_STRING[@difficulty-1]
  @ai_on = (ai_choice.eql? "Yes")
  @computer_set = nil
  if @ai_on
      @ai_player = Player.new AI
      @computer = Computer.new @difficulty
      @timer_inst.start_ai @player, @computer, self
  else
      @timer_inst.start @player
  end

  @player_state.text = "Player Name: " + @player.name + "\tPlayer Score: " + @player.score.to_s + ", "
  if !@ai_on
      @timer.text = "Timer: " + @timer_inst.timer_string
  else
      @ai_state.text = "Player Name: " + @ai_player.name + "\tPlayer Score: " + @ai_player.score.to_s
  end

  # Every 1 second does: updates score text, checks if AI made a set, and handles AI set verification
  every 1 do
      @player_state.text =  "Player Name: " + @player.name + "\tPlayer Score: " + @player.score.to_s + ", "
      if !@ai_on
          @timer.text = "Timer: " + @timer_inst.timer_string
      else
        unless @timer_inst.computer_set.nil?
          @clicked_imgs.clear
          set = @timer_inst.computer_set.clone
          @timer_inst.stop
          if Logic.new(*set).verifySet == 1
            # If there's a set, then: add score, remove the set, add multiples of 3 cards until a new set is possible,
            #     update board ui, then continue with game or proceed to endgame if conditions are met
            @ai_player.add_score
            @ai_state.text = "Player Name: " + @ai_player.name + "\tPlayer Score: " + @ai_player.score.to_s

            alert ALERT_AI_SET_FOUND

            @board.remove set

            @timer_inst.start_ai @player, @computer, self

            # Don't add cards if either the deck is empty OR if the @board still has 12+ cards after removing the last set
            if @board.size < 12 && @deck.size > 0
              @board.add [@deck.removeCard, @deck.removeCard, @deck.removeCard]
            end

            # Adds more cards if we don't have a set
            add_more_if_needed

            # Clears existing board ui before updating
            @imgs.each do |img|
              img.remove
            end

            update_board_ui

            trigger_endgame if @deck.size == 0 && @board.find_set == nil

            wait_for_input
          else
            # Then we don't have a set, so penalize player
            @ai_player.remove_score
            @ai_state.text = "Player Name: " + @ai_player.name + "\tPlayer Score: " + @ai_player.score.to_s
            alert ALERT_AI_NOT_A_SET
            @timer_inst.start_ai @player, @computer, self

            wait_for_input
          end
        end
      end
  end



  # Initialize the hint button text
  flow do
    para "Show me..."
  end

  # Draw initial board state
  update_board_ui

  # Begin main gameplay loop
  wait_for_input

end
