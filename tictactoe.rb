require "colorize"

class Player
  attr_accessor :number, :letter

  def initialize(number, letter)
    @number = number
    @letter = letter
  end

end

class Game
  attr_accessor :player, :winner

  def initialize()
    @player_one = Player.new(1, 'X')
    @player_two = Player.new(2, 'O')

    @player = @player_one 

    @cells = Array.new(9) { | i | (i + 1).to_s }
    @winner = nil 
  end

  def start()
    until cells_are_full? or has_winner? do
      system("clear") || system("cls") # clear console screen
      draw_board()
      get_chosen_cell()
      check_for_winner()
      swap_player() unless has_winner?
    end
    
    if cells_are_full?
      puts "Cells are now full, game is a draw"
    end

    if has_winner?
      puts "Winner is player #{@winner.number}"
    end

    display_cells()
  end

  def get_chosen_cell()
    #TODO: input validation
    #accept only 1 to 9
    #accept only unpopulated cells
    #accept only one character
    puts " " #newline
    puts "Choose a cell from 1-9 and only the unpopulated ones:".colorize(:blue)
    value = gets.chomp
    puts "You entered #{value}"
    @cells[value.to_i - 1] = @player.letter

  end

  def draw_board()
    puts "Current player is #{@player.number}".colorize(:green)
    puts " " #newline
    display_cells()
  end

  def display_cells() 
    puts "#{@cells[0]} | #{@cells[1]} | #{@cells[2]} " 
    puts "#{@cells[3]} | #{@cells[4]} | #{@cells[5]} " 
    puts "#{@cells[6]} | #{@cells[7]} | #{@cells[8]} "  
  end
  

  def swap_player()
    @player = @player == @player_one ? @player_two : @player_one 
  end

  def cells_are_full?()
    @cells.all? { |cells| cells == @player_one.letter or cells == @player_two.letter }
  end

  def check_for_winner()
    cells_to_eval = [[0,1,2], [3,4,5], [6,7,8],
                     [0,3,6], [1,4,7], [2,5,8],
                     [0,4,8], [2,4,6]]

    cells_to_eval.each do | c |
      matching_cells, value = check_matching_values(c[0], c[1], c[2])
      if matching_cells 
        p "cells are the matching for #{c}"
        value == @player_one.letter ? @winner = @player_one : @winner = @player_two
      end 
    end

  end

  def check_matching_values(idx1, idx2, idx3)
    cells = [ @cells[idx1], @cells[idx2], @cells[idx3] ] 
    same_value = false
    value = nil

    if cells.uniq.length == 1
      same_value = true  
      value = cells.uniq[0]
    end

    return same_value, value
  end

  def has_winner?()
    @winner == nil ? false : true 
  end
  
end

mygame = Game.new
mygame.start
