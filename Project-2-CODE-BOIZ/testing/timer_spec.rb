# File created 9/18/2019 by Zach Venables
# Edited on 9/18/2019 by Zach Venables
#Edited on 9/19 by Zach Venables
require 'rspec'
require_relative '../src/Timer'
require_relative '../src/player'

describe 'Timer' do

  it "creates a timer" do
    timer = Timer.new 1000
    expect(timer.time_entry).to eq(1000)
  end

  it "creates a timer" do
    timer = Timer.new 1
    expect(timer.time_entry).to eq(1)
  end

  it "creates a timer" do
    timer = Timer.new 234
    expect(timer.time_entry).to eq(234)
  end

  it "starts timer" do
    player = Player.new

    timer = Timer.new(1)
    timer.start player
    sleep 2

    expect(player.score).to eq(-1)
  end

  it "starts timer" do
    player = Player.new
    player.score = 13

    timer = Timer.new 1

    timer.start player
    sleep 2
    timer.start player
    sleep 2
    timer.start player
    sleep 2

    expect(player.score).to eq(10)
  end

  it "starts timer" do
    player = Player.new
    player.score = 420
    timer = Timer.new 1

    timer.start player
    sleep 2
    player.add_score
    timer.start player
    sleep 2

    expect(player.score).to eq(419)
  end

  it "stops the timer" do
    player = Player.new
    timer = Timer.new 3

    timer.start player
    timer.stop
    sleep 3

    expect(player.score).to eq(0)
  end

end