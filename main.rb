# frozen_string_literal: true

require './lib/player'
require './lib/game'

player1 = Player.new(1)
player2 = Player.new(2)
Game.new(player1, player2).play
