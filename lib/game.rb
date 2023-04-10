# frozen_string_literal: true

require './lib/display'

class Game
  include Display

  attr_accessor :board_positions, :winner, :game_over

  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize(player1, player2)
    @board_positions = %w[1 2 3 4 5 6 7 8 9]
    @game_over = false
    @winner = nil
    @player1 = player1
    @player2 = player2
  end

  def play
    player = @player1
    available_positions = board_positions.map(&:to_i)

    until @game_over
      show_board
      message = "#{player.name}: Please choose a position from the available positions on the board.\n"
      position = prompt(message).to_i

      next unless available_positions.include?(position)

      available_positions.delete(position)
      board_positions[position - 1] = player.game_piece

      check_if_winner(player)
      check_if_stalemate(available_positions)

      player = switch_player(player)
    end

    display_winner
  end

  private

  def switch_player(current_player)
    current_player == @player1 ? @player2 : @player1
  end

  def check_if_stalemate(available_positions)
    @game_over = true if available_positions.empty? && !@winner
  end

  def check_if_winner(player)
    WINNING_COMBINATIONS.each do |combination|
      arr = combination.map do |position|
        board_positions[position]
      end

      next unless arr.join =~ /#{player.game_piece}{3}/

      @winner = player
      player.score += 1
      @game_over = true
    end
  end

  def display_winner
    show_board
    if @winner
      puts "#{winner.name} is the winner"
    else
      puts 'Game is a draw, no one wins'
    end

    if prompt_play_again == 'Y'
      Game.new(@player1, @player2).play
    else
      show_board
      puts 'Thank you for playing!'
    end
  end

  def prompt_play_again
    prompt('Would you like to play again? [Y/N]').upcase
  end
end
