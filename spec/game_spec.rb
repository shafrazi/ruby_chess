require "./lib/game"

describe Game do
  game = Game.new
  describe "#initialize" do
    it "should return the correct number of players" do
      expect(game.players.length).to eql(2)
    end
  end

  describe "#create_players" do
    it "should return the first element as player 1" do
      expect(game.players[0].name).to eql("Player 1")
    end
  end
end
