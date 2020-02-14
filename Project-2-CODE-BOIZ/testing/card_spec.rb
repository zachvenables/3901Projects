# File created 9/15/2019 by Andrew Petrilli
# Edited on 9/19/2019 by Andrew Petrilli

require 'rspec'
require_relative '../src/Card'

# Created on 9/15/2019 by Andrew Petrilli
describe 'Card Tests' do
  # Created on 9/15/2019 by Andrew Petrilli
  it 'Create card' do
    card = Card.new 1, "red", "solid", "diamond", 1
    expect(card.number).to eq 1
    expect(card.color).to eq "red"
    expect(card.fill).to eq "solid"
    expect(card.shape).to eq "diamond"
    expect(card.img_num).to eq 1
  end

  # Created on 9/15/2019 by Andrew Petrilli
  it 'card equality' do
    card1 = Card.new 1, "red", "solid", "diamond", 1
    card2 = Card.new 1, "red", "solid", "diamond", 1
    expect(card1).to eq card2 # expect().to eq uses ==
  end

  # Created on 9/15/2019 by Andrew Petrilli
  it 'card not equal' do
    card1 = Card.new 1, "red", "solid", "diamond", 1
    card2 = Card.new 3, "blue", "fill", "squiggle", 2
    expect(card1).to_not eq card2 # uses ==
  end

  # Created on 9/19/2019 by Andrew Petrilli
  it 'card equality - same card object' do
    card1 = Card.new 1, "red", "solid", "diamond", 1
    card2 = card1
    expect(card1).to eq card2 # expect().to eq uses ==
  end
end
