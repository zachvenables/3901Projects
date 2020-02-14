# File created 9/6/2019 by Matthew Kelch
# File edited 9/12/2019 by Matthew Kelch
# Edited on 9/17/2019 by Matthew Kelch

# Created 9/6/2019 by Matthew Kelch
class Board
  # Created 9/6/2019 by Matthew Kelch
  # Getter
  attr_reader :state

  # Created 9/6/2019 by Matthew Kelch
  # Constructor
  # state should be an array of Card objects to be placed onto the board
  def initialize(state)
    @state = state.clone
  end

  # Created 9/6/2019 by Matthew Kelch
  # Edited 9/17/2019 by Matthew Kelch
  # Removes the specified cards from the array, replacing them with "nil"
  # cards should be an array of Card objects that are in @state
  def remove(cards)
    until cards.length == 0
      @state[@state.find_index cards.shift] = nil
    end
  end

  # Created 9/6/2019 by Matthew Kelch
  # Adds the specified cards to the board, filling in nil spaces
  # cards should be an array of Card objects that are in @state
  def add(cards)
    # append cards if there are no empty spaces
    if !@state.include? nil
      @state = @state + cards
    else
      until cards.length == 0
        @state[@state.find_index nil] = cards.shift
      end
    end
  end

  # Created 9/8/2019 by Matthew Kelch
  # Returns the number of cards on the board (i.e. number of non-nil elements in @state)
  def size
    @state.size - @state.count(nil)
  end

  # Created 9/12/2019 by Matthew Kelch
  # Returns an array of 3 cards in board.state that form a set; or nil if no set is found
  def find_set
    combos = @state.combination(3).to_a
    is_a_set = false
    while combos.size > 0 && !is_a_set
      combo = combos.pop
      # Don't want to pass a combination including a nil value
      next if combo.include? nil
      is_a_set = Logic.new(*combo).verifySet == 1
    end

    if is_a_set
      return combo
    else
      return nil
    end
  end
end