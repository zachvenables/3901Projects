
# File created 9/5/2019 by Zach Venables
# Edited on 9/14/2019 by Zach Venables
#Edited on 9/19 by zach venables


# File created on 9/18/2019 by Zach Venables

require 'rspec'
require_relative "../src/player"

describe "Player" do
  it "creates a player" do
    player = Player.new

    expect(player.name).to eq("NoEntry")
    expect(player.score).to eq(0)
  end
  it "creates a player" do
    player = Player.new"Ted"

    expect(player.name).to eq("Ted")
    expect(player.score).to eq(0)
  end
  it "creates a player" do
    player = Player.new 123, 1

    expect(player.name).to eq("123")
    expect(player.score).to eq(1)
  end

  it "adds one to the player score" do
    player = Player.new "Bob", 0

    player.add_score
    expect(player.score).to eq(1)
  end
  it "adds one to the player score" do
    player = Player.new "Bob"

    player.add_score
    expect(player.score).to eq(1)
  end
  it "adds one to the player score" do
    player = Player.new

    player.add_score
    expect(player.score).to eq(1)
  end
  it "adds one to the player score" do
    player = Player.new

    player.add_score
    player.add_score
    player.add_score
    player.add_score
    expect(player.score).to eq(4)
  end

  it "reduces player score" do
    player = Player.new
    player.remove_score
    expect(player.score).to eq(-1)
  end

  it "reduces player score" do
    player = Player.new
    player.score = 15
    player.remove_score
    player.remove_score
    expect(player.score).to eq(13)
  end

end