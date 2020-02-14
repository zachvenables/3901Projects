# File created 9/5/2019 by Andrew Petrilli
# Edited 9/7/2019 by Andrew Petrilli
# Edited 9/19/2019 by Andrew Petrilli

# Created 9/5/2019 by Andrew Petrilli
# Edited 9/19/2019 by Andrew Petrilli
class Card
  # Created 9/5/2019 by Andrew Petrilli
  # Defining accessors
  attr_reader :number
  attr_reader :color
  attr_reader :fill
  attr_reader :shape
  attr_reader :img_num

  # Created 9/5/2019 by Andrew Petrill
  # Constructor
  def initialize(number, color, fill, shape, img_num)
    @number = number
    @color = color
    @fill = fill
    @shape = shape
    @img_num = img_num
  end

  # Created 9/7/2019 by Andrew Petrilli
  # Edited 9/19/2019 by Andrew Petrilli
  # Comparison method for Card objects, checks for value equality
  def ==(card)
    card.class == self.class && card.state == self.state
  end 

  # Created 9/7/2019 by Andrew Petrilli
  # Edited 9/19/2019 by Andrew Petrilli
  # Helper method for ==, returns state of card
  protected
  def state
    [@number, @color, @fill, @shape, @img_num]
  end
end
