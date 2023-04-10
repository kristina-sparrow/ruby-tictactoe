# frozen_string_literal: true

require './lib/player'
require './lib/game'

p1 = Player.new(1)
p2 = Player.new(2)
Game.new(p1, p2).play
