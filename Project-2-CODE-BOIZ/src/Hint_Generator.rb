# File created on 9/15/2019 by Andrew Petrilli
# File edited on 9/18/2019 by Matthew Kelch

# Created on 9/15/2019 by Andrew Petrilli
class Hint
  # Created on 9/15/2019 by Andrew Petrilli
  # Edited on 9/18/2019 by Matthew Kelch - Now returns a string instead of puts -ing the string
=begin
  Gives player a hint of varying helpfulness, which corresponds to level (1-4)
  @requires at least one set is present in board
=end
  def self.give_hint(level, board)
    sets = find_sets(board)
    case level
    when 1
      "There are #{sets.length} sets available."
    when 2
      "The card (#{board.state.find_index sets[0][0]}) is a part of a set."
    when 3
      "The cards (#{board.state.find_index sets[0][0]}) and (#{board.state.find_index sets[0][1]}) are a part of a set."
    when 4
      "The cards (#{board.state.find_index sets[0][0]}), (#{board.state.find_index sets[0][1]}), and (#{board.state.find_index sets[0][2]}) are a set."
    end
  end

  # Created on 9/15/2019 by Andrew Petrilli
  # Edited on 9/18/2019 by Matthew Kelch - Should now skip a combo if it contains nil
  # Returns an array of arrays, each entry in sets is a set from board
  def self.find_sets(board)
    combos = board.state.combination(3).to_a
    sets = Array.new(0)
    combos.each { |combo|
      next if combo.include? nil
      if Logic.new(*combo).verifySet == 1
        sets.push(combo)
      end
    }
    sets
  end
end
