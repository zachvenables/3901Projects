# File created 9/8/2019 by Neil Mckibben
# Edited 9/9/2019 by Neil Mckibben
# Edited 9/12/2019 by Matthew Kelch
require_relative("Card")


Numbers = [1, 2, 3]
Colors = ["red", "purple", "green"]
Shapes = ["squiggle", "diamond", "oval"]
Fills = ["solid", "striped", "outlined"]
Size = Numbers.length * Shapes.length * Colors.length * Fills.length

# Created 9/8/2019 by Neil Mckibben
class Deck
  # Created 9/8/2019 by Neil Mckibben
  # Accessor for deck card
  attr_reader :cards
  attr_reader :counter
  attr_reader :size

  # Created 9/9/2019 by Neil Mckibben
  # Constructor for Deck
  def initialize()
    @cards = generateCards
    @counter = 0 #Pointer to the current index of the array.
    @size = Size
  end

  # Created 9/8\9/2019 by Neil Mckibben
  # Generates all of the cards based off of the defined card constants
  def generateCards()
      cards = Array.new(Size)
      index = 0
      Fills.each do |fill|
          Shapes.each do |shape|
              Colors.each do |color|
                  Numbers.each do |nums|
                      card = Card.new(nums, color, fill, shape, index+1)
                      cards[index] = card
                      index += 1
                  end
              end
          end
      end
  return cards.shuffle #Shuffles are the cards randomly
  end

  # Created 9/9/2019 by Neil Mckibben
  #Removes a single card and updates the indexes correctly
  def removeCard()
      card = @cards[@counter] #Remove card at the most current index
      @counter += 1 # Increment the counter since that card is "removed"
      @size -= 1 #Decrement size since card is removed
      return card
  end
end
