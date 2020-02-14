# File created 9/15/2019 by Neil Mckibben

require 'rspec'
require_relative '../src/Deck'
require_relative '../src/Card'
# Created on 9/15/2019 by Neil Mckibben
describe 'Deck Tests' do
  # Created on 9/15/2019 by Neil Mckibben
  it 'Create Deck' do
    deck = Deck.new
    expect(deck.size).to eq 81
    expect(deck.counter).to eq 0
  end

  it 'Create Deck and check for card object in each' do
    deck = Deck.new
    for i in 0...81 do
        card = deck.cards[i]
        expect(card.instance_of? Card).to eq true
    end
    expect(deck.size).to eq 81
    expect(deck.counter).to eq 0
  end

  it 'Remove card' do
    deck = Deck.new
    card = deck.removeCard
    expect(card.instance_of? Card).to eq true
    expect(deck.size).to eq 80
    expect(deck.counter).to eq 1
  end

  it 'Remove two cards' do
    deck = Deck.new
    card = deck.removeCard
    card_two = deck.removeCard
    expect(card.instance_of? Card).to eq true
    expect(card_two.instance_of? Card).to eq true
    expect(deck.size).to eq 79
    expect(deck.counter).to eq 2
  end

  it 'Remove everything but one card from the deck' do
    deck = Deck.new
    for i in 0...80 do
      card = deck.removeCard
      expect(card.instance_of? Card).to eq true
    end
    expect(deck.size).to eq 1
    expect(deck.counter).to eq 80
  end

  it 'Remove everything from the deck' do
    deck = Deck.new
    for i in 0...81 do
      card = deck.removeCard
      expect(card.instance_of? Card).to eq true
    end
    expect(deck.size).to eq 0
    expect(deck.counter).to eq 81
  end

end
