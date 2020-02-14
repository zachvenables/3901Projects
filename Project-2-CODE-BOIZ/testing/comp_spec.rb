#Created by Sean Simpson 9/20/19
require 'rspec'
require_relative '../src/Card'
require_relative '../src/Deck'
require_relative '../src/Board'
require_relative '../src/Logic'
require_relative '../src/Computer'

describe 'Computer' do
	before(:each) do
		@deck = Deck.new
		@deck2 = Deck.new
		@deck3 = Deck.new
		@deck4 = Deck.new
		@deck5 = Deck.new
		@deck6 = Deck.new
		@deck7 = Deck.new
		@deck8 = Deck.new
		@deck9 = Deck.new
		@hand = Array.new
        12.times {@hand.push @deck.removeCard}
        @hand2 = Array.new
        12.times {@hand2.push @deck2.removeCard}
        @hand3 = Array.new
        12.times {@hand3.push @deck3.removeCard}
        @hand4 = Array.new
        12.times {@hand4.push @deck4.removeCard}
        @hand5 = Array.new
        12.times {@hand5.push @deck5.removeCard}
        @hand6 = Array.new
        12.times {@hand6.push @deck6.removeCard}
        @hand7 = Array.new
        12.times {@hand7.push @deck7.removeCard}
        @hand8 = Array.new
        12.times {@hand8.push @deck8.removeCard}
        @hand9 = Array.new
        12.times {@hand9.push @deck9.removeCard}
		@board = Board.new @hand
		@board2 = Board.new @hand2
		@board3 = Board.new @hand3
		@board4 = Board.new @hand4
		@board5 = Board.new @hand5
		@board6 = Board.new @hand6
		@board7 = Board.new @hand7
		@board8 = Board.new @hand8
		@board9 = Board.new @hand9
		@comp = Computer.new(1)
		@medComp = Computer.new(2)
	end

describe 'verifyCompCanFail' do
 it 'checks the computer sometimes fails' do
 	set = @comp.playMode(@board)
 	set2 = @comp.playMode(@board2)
 	set3 = @comp.playMode(@board3)
 	set4 = @comp.playMode(@board4)
 	set5 = @comp.playMode(@board5)
 	set6 = @comp.playMode(@board6)
 	set7 = @comp.playMode(@board7)
 	set8 = @comp.playMode(@board8)
 	set9 = @comp.playMode(@board9)
 	logic = Logic.new(set[0],set[1],set[2])
 	logic2 = Logic.new(set2[0],set2[1],set2[2])
 	logic3 = Logic.new(set3[0],set3[1],set3[2])
 	logic4 = Logic.new(set4[0],set4[1],set4[2])
 	logic5 = Logic.new(set5[0],set5[1],set5[2])
 	logic6 = Logic.new(set6[0],set6[1],set6[2])
 	logic7 = Logic.new(set7[0],set7[1],set7[2])
 	logic8 = Logic.new(set8[0],set8[1],set8[2])
 	logic9 = Logic.new(set9[0],set9[1],set9[2])
 	shouldNotBePerfect = 9
 	score = 0
 	score += logic.verifySet
 	score += logic2.verifySet
 	score += logic3.verifySet
 	score += logic4.verifySet
 	score += logic5.verifySet
 	score += logic6.verifySet
 	score += logic7.verifySet
 	score += logic8.verifySet
 	score += logic9.verifySet
 	expect(score).to be < shouldNotBePerfect
 	end
 end
end