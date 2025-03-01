
class Game
  attr_accessor :player, :winner

  def initialize()
    @player_one = Player.new(1, 'X')
    @player_two = Player.new(2, 'O')

    @player = @player_one 

    @cells = Array.new(9) { | i | (i + 1).to_s }
    @winner = nil 
  end

  def clear_screen()
    system("clear") || system("cls") # clear console screen
  end

  def start()
    until cells_are_full? or has_winner? do
      clear_screen() 
      draw_board()
      get_chosen_cell()
      check_for_winner()
      swap_player() unless has_winner?
    end
    
    clear_screen()

    if cells_are_full?
      puts "Cells are now full, game is a draw"
    end

    if has_winner?
      puts "Winner is player #{@winner.number}".colorize(:green)
    end

    display_cells()
  end

  def get_chosen_cell()
    puts " " #newline
    puts "Choose a cell from 1-9 and only the unpopulated ones:".colorize(:blue)

    user_input = nil
    until valid_input?(user_input) and vacant_cell?(user_input) do 
      user_input = gets.chomp
      puts "You entered #{user_input}"

      if not valid_input?(user_input)
        puts "Invalid input only numbers 1-9, one character".colorize(:red)
      end

      if not vacant_cell?(user_input)
        puts "Cell #{user_input} is not empty. Please choose an empty cell".colorize(:red)
      end

    end
      @cells[user_input.to_i - 1] = @player.letter
  end

  def valid_input?(input)
    !!(input =~ /^[1-9]$/)
  end

  def vacant_cell?(input)
    if !valid_input?(input)
      false
    else
      return (@cells[input.to_i - 1] == @player_one.letter or @cells[input.to_i - 1] == @player_two.letter) ? false : true
    end
  end

  def draw_board()
    puts "Current player is #{@player.number}".colorize(:green)
    puts " " #newline
    display_cells()
  end

  def display_cells() 
    puts "#{show_cell(0)} | #{show_cell(1)} | #{show_cell(2)} " 
    puts "#{show_cell(3)} | #{show_cell(4)} | #{show_cell(5)} " 
    puts "#{show_cell(6)} | #{show_cell(7)} | #{show_cell(8)} " 
  end

  def show_cell(index) #added color
    if @cells[index] == @player_one.letter
      @cells[index].colorize(:red)
    elsif @cells[index] == @player_two.letter
      @cells[index].colorize(:blue)
    else
      @cells[index].colorize(:green)
    end
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


