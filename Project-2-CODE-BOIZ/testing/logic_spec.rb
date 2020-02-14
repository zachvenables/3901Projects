#File created 9/19/19 by Sean Simpson

require 'rspec'
require_relative '../src/Card'
require_relative '../src/Logic'

describe 'Logic' do
	before(:each) do
@logic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","striped","diamond",2),Card.new(3,"green","outlined","oval",3))
@invalidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","striped","diamond",2),Card.new(1,"green","outlined","oval",3))
@numValidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(1,"purple","striped","diamond",2),Card.new(1,"green","outlined","oval",3))
@numDifValidLogic = Logic.new(Card.new(2,"red","solid","squiggle",1),Card.new(1,"purple","striped","diamond",2),Card.new(3,"green","outlined","oval",3))
@numInvalidLogic = Logic.new(Card.new(2,"red","solid","squiggle",1),Card.new(1,"purple","striped","diamond",2),Card.new(1,"green","outlined","oval",3))
@colorValidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"red","striped","diamond",2),Card.new(3,"red","outlined","oval",3))
@colorDifValidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","striped","diamond",2),Card.new(3,"green","outlined","oval",3))
@colorInvalidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"red","striped","diamond",2),Card.new(3,"green","outlined","oval",3))
@fillValidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","solid","diamond",2),Card.new(3,"green","solid","oval",3))
@fillDifValidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","striped","diamond",2),Card.new(3,"green","outlined","oval",3))
@fillInvalidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","solid","diamond",2),Card.new(3,"green","outlined","oval",3))
@shapeValidLogic = Logic.new(Card.new(1,"red","solid","oval",1),Card.new(2,"purple","striped","oval",2),Card.new(3,"green","outlined","oval",3))
@shapeDifValidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","striped","diamond",2),Card.new(3,"green","outlined","oval",3))
@shapeInvalidLogic = Logic.new(Card.new(1,"red","solid","squiggle",1),Card.new(2,"purple","striped","diamond",2),Card.new(3,"green","outlined","diamond",3))
end


describe 'verifySet' do
 it 'checks a valid set' do
 	valid = @logic.verifySet
 	expectedValue = 1
 	expect(valid).to eq expectedValue
 	end
 end

 describe 'invalidSet' do
 	it 'Checks for an invalid result' do
 	invalid = @invalidLogic.verifySet
 	expectedValue = -1
 	expect(invalid).to eq expectedValue
 	end
 end

 describe 'testingNumSetAttribute' do
 it 'checks a valid response for all same' do
 	valid = @numValidLogic.numberValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks a valid response for all different' do
 	valid = @numDifValidLogic.numberValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks for an invalid response for set' do
 	invalid = @numInvalidLogic.numberValid
 	expectedValue = false
 	expect(invalid).to eq expectedValue
 	end
 end

  describe 'testingShapeSetAttribute' do
 it 'checks a valid response for all same' do
 	valid = @shapeValidLogic.shapeValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks a valid response for all different' do
 	valid = @shapeDifValidLogic.shapeValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks for an invalid response for set' do
 	invalid = @shapeInvalidLogic.shapeValid
 	expectedValue = false
 	expect(invalid).to eq expectedValue
 	end
 end

  describe 'testingFillSetAttribute' do
 it 'checks a valid response for all same' do
 	valid = @fillValidLogic.fillValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks a valid response for all different' do
 	valid = @fillDifValidLogic.fillValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks for an invalid response for set' do
 	invalid = @fillInvalidLogic.fillValid
 	expectedValue = false
 	expect(invalid).to eq expectedValue
 	end
 end

  describe 'testingColorSetAttribute' do
 it 'checks a valid response for all same' do
 	valid = @colorValidLogic.colorValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks a valid response for all different' do
 	valid = @colorDifValidLogic.colorValid
 	expectedValue = true
 	expect(valid).to eq expectedValue
 	end
 	it 'checks for an invalid response for set' do
 	invalid = @colorInvalidLogic.colorValid
 	expectedValue = false
 	expect(invalid).to eq expectedValue
 	end
 end

 end