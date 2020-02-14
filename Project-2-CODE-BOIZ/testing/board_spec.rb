# File created 9/16/2019 by Matthew Kelch

require 'rspec'
require_relative '../src/Card'
require_relative '../src/Board'
require_relative '../src/Logic'

# Created on 9/16/2019 by Matthew Kelch
describe 'Board' do
  before(:each) do
    @non_nil_arr = [Card.new(1, "red", "solid", "oval", 1),
            Card.new(2, "purple", "striped", "oval", 2),
            Card.new(3, "green", "striped", "squiggle", 3),
            Card.new(1, "purple", "solid", "squiggle", 4),
            Card.new(2, "red", "empty", "diamond", 5),
            Card.new(3, "red", "empty", "diamond", 6),
            Card.new(1, "green", "solid", "diamond", 7),
            Card.new(2, "green", "solid", "oval", 8),
            Card.new(3, "purple", "empty", "squiggle", 9),
            Card.new(1, "red", "striped", "squiggle", 10),
            Card.new(2, "purple", "solid", "oval", 11),
            Card.new(3, "red", "solid", "diamond", 12)]

    @some_nil_arr = [Card.new(1, "red", "solid", "oval", 1),
                    Card.new(2, "purple", "striped", "oval", 2),
                    Card.new(3, "green", "striped", "squiggle", 3),
                    Card.new(1, "purple", "solid", "squiggle", 4),
                    Card.new(2, "red", "empty", "diamond", 5),
                    Card.new(3, "red", "empty", "diamond", 6),
                    Card.new(1, "green", "solid", "diamond", 7),
                    Card.new(2, "green", "solid", "oval", 8),
                    Card.new(3, "purple", "empty", "squiggle", 9),
                    nil,
                    nil,
                    nil]

    @size_15_arr = [Card.new(1, "red", "solid", "oval", 1),
                    Card.new(2, "purple", "striped", "oval", 2),
                    Card.new(3, "green", "striped", "squiggle", 3),
                    Card.new(1, "purple", "solid", "squiggle", 4),
                    Card.new(2, "red", "empty", "diamond", 5),
                    Card.new(3, "red", "empty", "diamond", 6),
                    Card.new(1, "green", "solid", "diamond", 7),
                    Card.new(2, "green", "solid", "oval", 8),
                    Card.new(3, "purple", "empty", "squiggle", 9),
                    Card.new(1, "red", "striped", "squiggle", 10),
                    Card.new(2, "purple", "solid", "oval", 11),
                    Card.new(3, "red", "solid", "diamond", 12),
                    Card.new(2, "red", "striped", "oval", 13),
                    Card.new(1, "green", "striped", "squiggle", 14),
                    Card.new(2, "purple", "striped", "squiggle", 15)]
  end

  # Created on 9/16/2019 by Matthew Kelch
  describe 'create a board' do
    it 'creates an empty board when empty array is passed' do
      arr = []
      board = Board.new arr
      expect(board.state).to eq arr
      expect(board.state.equal? arr).to eq false
    end

    it 'creates a non-empty board when a non-empty array is passed' do
      board = Board.new @non_nil_arr
      expect(board.state).to eq @non_nil_arr
      expect(board.state.equal? @non_nil_arr).to eq false
    end
  end

  describe 'removing cards from a board' do
    it 'returns array of 9 cards and 3 nil when initial board has 12 cards' do
      to_remove = [Card.new(1, "red", "solid", "oval", 1),
                   Card.new(2, "purple", "striped", "oval", 2),
                   Card.new(3, "green", "striped", "squiggle", 3)]
      expected_arr = [nil,
                      nil,
                      nil,
                      Card.new(1, "purple", "solid", "squiggle", 4),
                      Card.new(2, "red", "empty", "diamond", 5),
                      Card.new(3, "red", "empty", "diamond", 6),
                      Card.new(1, "green", "solid", "diamond", 7),
                      Card.new(2, "green", "solid", "oval", 8),
                      Card.new(3, "purple", "empty", "squiggle", 9),
                      Card.new(1, "red", "striped", "squiggle", 10),
                      Card.new(2, "purple", "solid", "oval", 11),
                      Card.new(3, "red", "solid", "diamond", 12)]
      board = Board.new @non_nil_arr
      board.remove(to_remove)
      expect(board.state).to eq expected_arr
    end

    it 'returns an array of 6 cards and 6 nil when initial array has 9 cards and 3 nil' do
      to_remove = [Card.new(1, "red", "solid", "oval", 1),
                   Card.new(2, "purple", "striped", "oval", 2),
                   Card.new(3, "green", "striped", "squiggle", 3)]
      expected_arr = [nil,
                      nil,
                      nil,
                      Card.new(1, "purple", "solid", "squiggle", 4),
                      Card.new(2, "red", "empty", "diamond", 5),
                      Card.new(3, "red", "empty", "diamond", 6),
                      Card.new(1, "green", "solid", "diamond", 7),
                      Card.new(2, "green", "solid", "oval", 8),
                      Card.new(3, "purple", "empty", "squiggle", 9),
                      nil,
                      nil,
                      nil]
      board = Board.new @some_nil_arr
      board.remove(to_remove)
      expect(board.state).to eq expected_arr
    end

    it 'returns an array of 12 cards when initial array has 15 cards' do
      to_remove = [Card.new(1, "red", "solid", "oval", 1),
                   Card.new(2, "purple", "striped", "oval", 2),
                   Card.new(3, "green", "striped", "squiggle", 3)]
      expected_arr = [nil,
                      nil,
                      nil,
                      Card.new(1, "purple", "solid", "squiggle", 4),
                      Card.new(2, "red", "empty", "diamond", 5),
                      Card.new(3, "red", "empty", "diamond", 6),
                      Card.new(1, "green", "solid", "diamond", 7),
                      Card.new(2, "green", "solid", "oval", 8),
                      Card.new(3, "purple", "empty", "squiggle", 9),
                      Card.new(1, "red", "striped", "squiggle", 10),
                      Card.new(2, "purple", "solid", "oval", 11),
                      Card.new(3, "red", "solid", "diamond", 12),
                      Card.new(2, "red", "striped", "oval", 13),
                      Card.new(1, "green", "striped", "squiggle", 14),
                      Card.new(2, "purple", "striped", "squiggle", 15)]
      board = Board.new @size_15_arr
      board.remove(to_remove)
      expect(board.state).to eq expected_arr
    end
  end

  describe 'adding cards to a board' do
    it 'returns array of 12 non-nil cards when initial board has 9 cards' do
      to_add = [Card.new(1, "red", "solid", "oval", 1),
                   Card.new(2, "purple", "striped", "oval", 2),
                   Card.new(3, "green", "striped", "squiggle", 3)]
      expected_arr = [Card.new(1, "red", "solid", "oval", 1),
                      Card.new(2, "purple", "striped", "oval", 2),
                      Card.new(3, "green", "striped", "squiggle", 3),
                      Card.new(1, "purple", "solid", "squiggle", 4),
                      Card.new(2, "red", "empty", "diamond", 5),
                      Card.new(3, "red", "empty", "diamond", 6),
                      Card.new(1, "green", "solid", "diamond", 7),
                      Card.new(2, "green", "solid", "oval", 8),
                      Card.new(3, "purple", "empty", "squiggle", 9),
                      Card.new(1, "red", "solid", "oval", 1),
                      Card.new(2, "purple", "striped", "oval", 2),
                      Card.new(3, "green", "striped", "squiggle", 3)]
      board = Board.new @some_nil_arr
      board.add(to_add)
      expect(board.state).to eq expected_arr
    end

    it 'returns array of 15 cards when initial board has 12 cards' do
      to_add = [Card.new(1, "red", "solid", "oval", 1),
                Card.new(2, "purple", "striped", "oval", 2),
                Card.new(3, "green", "striped", "squiggle", 3)]
      expected_arr = @size_15_arr

      board = Board.new([nil,
                              nil,
                              nil,
                              Card.new(1, "purple", "solid", "squiggle", 4),
                              Card.new(2, "red", "empty", "diamond", 5),
                              Card.new(3, "red", "empty", "diamond", 6),
                              Card.new(1, "green", "solid", "diamond", 7),
                              Card.new(2, "green", "solid", "oval", 8),
                              Card.new(3, "purple", "empty", "squiggle", 9),
                              Card.new(1, "red", "striped", "squiggle", 10),
                              Card.new(2, "purple", "solid", "oval", 11),
                              Card.new(3, "red", "solid", "diamond", 12),
                              Card.new(2, "red", "striped", "oval", 13),
                              Card.new(1, "green", "striped", "squiggle", 14),
                              Card.new(2, "purple", "striped", "squiggle", 15)])
      board.add(to_add)
      expect(board.state).to eq expected_arr
    end
  end

  describe 'finding the number of cards on a board' do
    it 'returns 9 when there are 9 cards, 3 nil' do
      board = Board.new @some_nil_arr

      expect(board.size).to eq 9
    end

    it 'returns 15 when there are 15 non-nil cards' do
      board = Board.new @size_15_arr

      expect(board.size).to eq 15
    end

    it 'returns 0 when all objects on board are nil' do
      board = Board.new [nil,nil,nil]

      expect(board.size).to eq 0
    end
  end

  describe 'finding a set on a board' do
    it 'returns nil when there is no set' do
      board = Board.new [Card.new(1, "red", "solid", "oval", 1),
                         Card.new(2, "purple", "striped", "oval", 2),
                         Card.new(3, "green", "striped", "squiggle", 3)]
      expect(board.find_set).to eq nil
    end

    it 'returns an arbitrary set when there exists a set on the board' do
      board = Board.new @non_nil_arr
      set = board.find_set
      logic = Logic.new *set

      expect(logic.verifySet).to eq 1
      # all 3 cards in the set should be in the board too
      expect((board.state - set).length).to eq 9
    end
  end

  it 'returns a single arbitrary set when there exists multiple sets' do
    board = Board.new [Card.new(1, "red", "solid", "oval", 1),
                           Card.new(2, "red", "solid", "oval", 2),
                           Card.new(3, "red", "solid", "oval", 3),
                           Card.new(1, "green", "solid", "oval", 4),
                           Card.new(2, "green", "solid", "oval", 5),
                           Card.new(3, "green", "solid", "oval", 6)]
    set = board.find_set
    logic = Logic.new *set

    expect(logic.verifySet).to eq 1
    # all 3 cards in the set should be in the board too
    expect((board.state - set).length).to eq 3
  end

end
