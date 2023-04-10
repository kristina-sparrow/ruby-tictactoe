# frozen_string_literal: true

require './lib/display'

class Player
  include Display

  attr_reader :name, :game_piece, :other_game_piece

  def initialize(player_number, name: nil, piece: nil)
    @name = name || prompt_player_name(player_number)
    @game_piece = piece || prompt_game_piece(@name)
    @score = 0
    @other_game_piece = nil
  end

  private

  def prompt_player_name(player_number)
    banner
    prompt("Player #{player_number}: What is your name?")
  end

  def valid_game_piece?(piece)
    piece =~ /^[A-Z]\b/ && piece != other_game_piece
  end

  def prompt_game_piece(player_name)
    game_piece = ''

    loop do
      banner
      message = "#{player_name}: Choose a single letter to represent your piece.\n"
      message += "It cannot be #{other_game_piece}" if other_game_piece

      game_piece = prompt(message).upcase

      break if valid_game_piece?(game_piece)

      banner
      puts 'Invalid piece, please choose a single letter'
      sleep(2)
    end

    self.other_game_piece = game_piece
    game_piece
  end
end
