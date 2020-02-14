# File created 9/5/2019 by Zach Venables
# Edited 9/10/2019 by Zach Venables
# Edited 9/17/2019 by Zach Venables
# Edited 9/15/2019 by Andrew Petrilli
# Edited 9/18/2019 by Matthew Kelch

require_relative "player"
require_relative "Board"
require_relative "Card"
require_relative "Logic"
require_relative "Deck"
# Edited 9/15/2019 by Andrew Petrilli
require_relative "Hint_Generator"
require_relative "Timer"#Edited 9/17 by Venables


#Created by Zach Venables
#Edited 9/10/2019 by Zach Venables
# Print the board in a 3 X 4 text output
#params: the board refers to an array of cards that have been dealt to the board
def print_board(board)
  print"\n"
  i = 0
  while i < 4
    j = 0
    while j < 3
      if board.state[3*i + j] == nil
        printf("%24s", "Empty Space")
      else
        printf "(%-2s) " , 3*i + j
        printf "%-2s", board.state[3*i + j].number
        printf "%-8s", board.state[3*i + j].color
        printf "%-9s",board.state[3*i + j].fill
        printf "%-13s", board.state[3*i + j].shape
      end
      j += 1
    end
    print "\n"
    i += 1
  end
end

#Created by Zach Venables
#Edited 9/10/2019 by Zach Venables
#Prompts the player to select three cards and then returns them as an array of cards
#params: the board refers to an array of cards that have been dealt to the board
def card_select(board)
  invalid_selection = true

  #Checks the player entries to verify they are numeric, then passes the value to board.state
  while invalid_selection
    print"\nSelect first card for set (Enter an Integer): "
    entry = gets.chomp
    if (entry=~/^\D/) == nil && entry.length > 0#regular expression for anything non numeric
      entry = entry.to_i
      if entry.between?(0, board.size)
        invalid_selection = false
      end
    else
      puts"\nThat was not a valid entry."
    end
  end

  first_card = board.state[entry]
  invalid_selection = true

  while invalid_selection
    print"\nSelect second card for set (Enter an Integer): "
    entry = gets.chomp
    if (entry=~/^\D/) == nil && entry.length > 0
      entry = entry.to_i
      if entry.between?(0, board.size)
        invalid_selection = false
      end
    else
      puts"\nThat was not a valid entry."
    end
  end

  second_card = board.state[entry]
  invalid_selection = true

  while invalid_selection
    print "\nSelect third card for set (Enter an Integer): "
    entry = gets.chomp
    if (entry=~/^\D/) == nil && entry.length > 0
      entry = entry.to_i
      if entry.between?(0, board.size)
        invalid_selection = false
      end
    else
      puts"\nThat was not a valid entry."
    end
  end

  third_card = board.state[entry]

  return Array [first_card, second_card, third_card]
end

#Created by Zach Venables
#Edited 9/10/2019 by Zach Venables
#Beggining of actual game program
print"Welcome to CODE BOIZ Set Game!\n\nPlease enter your name: "
name = gets.chomp
player=Player.new name, 0

puts"\nHi, #{player.name}"
sleep 1

#Edited 9/17 by Venables
invalid_entry = true
#loop checks for numeric entry for timer input
while invalid_entry
  puts"What is your turn time limit?(Seconds)"
  time_entry = gets.chomp
  if (time_entry=~/^\D/) == nil#regular expression for anything non numeric
    invalid_entry = false
    time_entry = time_entry.to_i
  else
    puts"\nThat was not a valid entry."
  end
end
timer = Timer.new time_entry

#Build deck
deck = Deck.new
hand = Array.new

12.times do
  hand.push deck.removeCard
end



board = Board.new hand

print_board board

# Edited 9/15/2019 by Andrew Petrilli
hint_level = 1 # Keeps track of level of hint to give
#Runs the game continuously until no more sets are possible
while true

  if board.find_set == nil
    puts "No more sets on the board!"
    if deck.size == 0
      # Game is over
      break
    else
      puts "Adding more cards..."
      board.add [deck.removeCard, deck.removeCard, deck.removeCard]
      # Skip to next iteration in case there's still no set
      next
    end
  end

  timer.start player#edited 9/17 by Zach Venables creates timer thread

  # Created 9/15/2019 by Andrew Petrilli
  # Asks user if they want a hint until they don't type yes, or run out of hints (4)
  loop do
    puts "Would you like a hint? Type yes, otherwise hit enter."
    response = gets.chomp
    if response == "yes"
      puts Hint.give_hint hint_level, board
      if (hint_level += 1) > 4 then break end
    else
      break
    end
  end

  #Prompts players for cards
  card_selections = card_select board

  #pass cards numbers and board to logic check
  logic = Logic.new card_selections[0], card_selections[1], card_selections[2]

  #if cards  a set, player score++, if deck is not empty, deal 3 new, else play remaining car
  if logic.verifySet > 0

    timer.stop#edited 9/17 Zach Venables  kills timer thread

    hint_level = 1 # Resets hint level to 1 if player finds a set

    player.add_score
    puts "\nYup, that's a set!  Add one to #{player.name}'s score!"
    sleep 1
    player.show_score
    sleep 2
    board.remove card_selections

    new_cards = Array.new #deck class needs added then get cards from deck

    if deck.size > 0
      3.times do
        if deck.size > 0
          new_cards.push deck.removeCard
        end
      end
    end

    board.add new_cards

    print_board board
  else
    # else reject set and start at top of loop

    puts"\nThis is not a set, dude... Please select again!"
    sleep 2

    print_board board

    puts"This is not a set, dude... Please select again!"
      # Updated 9/16/2019 by Neil Mckibben, decrement player score when wrong
      player.remove_score
      #Prints score so player knows they lose points
      player.show_score

  end
end

print"Game Over!\nTotal Score is: #{player.score}"
