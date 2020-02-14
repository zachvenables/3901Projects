# File created 9/19/2019 by Andrew Petrilli
require 'rspec'
require_relative '../src/Hint_Generator'
require_relative '../src/Card'
require_relative '../src/Deck'
require_relative '../src/Board'
require_relative '../src/Logic'

# Created on 9/19/2019 by Andrew Petrilli
describe 'Hint Tests - find sets' do
  # Created on 9/19/2019 by Andrew Petrilli
  it 'Find sets empty board' do
    board = Board.new []
    sets = Hint.find_sets board
    expect(sets).to eq []
  end

  # Created on 9/19/2019 by Andrew Petrilli
  it 'Find sets one set' do
    card = Card.new 1, "red", "solid", "squiggle", 5
    board = Board.new [card, card, card]
    sets = Hint.find_sets board
    expect(sets).to eq [[card, card, card]]
  end

  # Created on 9/19/2019 by Andrew Petrilli
  it 'Find sets card no sets' do
    card_a = Card.new 1, "blue", "solid", "squiggle", 5
    card_b = Card.new 1, "red", "solid", "squiggle", 5
    card_c = Card.new 1, "red", "solid", "squiggle", 5
    board = Board.new [card_a, card_b, card_c]
    sets = Hint.find_sets board
    expect(sets).to eq []
  end

  # Created on 9/19/2019 by Andrew Petrilli
  describe "Hint Tests - give hint" do
    card_a = Card.new 1, "blue", "solid", "squiggle", 5
    card_b = Card.new 1, "red", "solid", "squiggle", 5
    card_c = Card.new 1, "green", "solid", "squiggle", 5
    board = Board.new [card_a, card_b, card_c]

    # Created on 9/19/2019 by Andrew Petrilli
    it 'Give hint - level 1' do
      hint = Hint.give_hint 1, board
      expect(hint).to eq "There are 1 sets available."
    end

    # Created on 9/19/2019 by Andrew Petrilli
    it 'Give hint - level 2' do
      hint = Hint.give_hint 2, board
      expect(hint).to eq "The card (#{board.state.find_index card_a}) is a part of a set."
    end

    # Created on 9/19/2019 by Andrew Petrilli
    it 'Give hint - level 3' do
      hint = Hint.give_hint 3, board
      expect(hint).to eq "The cards (#{board.state.find_index card_a}) and (#{board.state.find_index card_b}) are a part of a set."
    end

    # Created on 9/19/2019 by Andrew Petrilli
    it 'Give hint - level 4' do
      hint = Hint.give_hint 4, board
      expect(hint).to eq "The cards (#{board.state.find_index card_a}), (#{board.state.find_index card_b}), and (#{board.state.find_index card_c}) are a set."
    end
  end
end
