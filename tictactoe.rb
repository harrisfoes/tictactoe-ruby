# def check win condition
# 	check if matches horizontally
# 	vertically
# 	diagonally
# end
#
# while there is no winner or cells not fully populated
#   display the cell
# 	player (one or two) selects a cell
# 	cell is populated with x or o
# 	check win condition
# 	switch to next player
# end
#
# declare result, winner or draw
# play again? yes or no

module State
  PLAY = 1
  GAME_OVER = 2
end

class Player
  attr_accessor :number, :letter

  def initialize(number, letter)
    @number = number
    @letter = letter
  end

end

class Game
  attr_accessor :state, :player

  def initialize()
    @state = State::PLAY

    @player_one = Player.new(1, 'X')
    @player_two = Player.new(2, 'O')

    @player = @player_one 

    @cells = Array.new(9) { | i | (i + 1).to_s }


  end

  def start()
    draw()
    get_chosen_cell()
    swap_player()
  end

  def get_chosen_cell()
    
    puts "Choose a cell:"
    value = gets.chomp
    puts "You entered #{value}"
    @cells[value.to_i - 1] = @player.letter

  end

  def draw()
    puts "Current player is #{@player.number}"
    display_cells()
  end

  def display_cells() 
    #if cells are populated display as X or O
    #if cells are not, display s their numbers
    puts "#{@cells[0]} | #{@cells[1]} | #{@cells[2]} " 
    puts "#{@cells[3]} | #{@cells[4]} | #{@cells[5]} " 
    puts "#{@cells[6]} | #{@cells[7]} | #{@cells[8]} "  
  end
  

  def swap_player()
    @player == @player_one ? @player_two : @player_one 
  end

  def cells_are_full?()
    #check if all cells are X or Y 
    @cells.all? { |cells| cells == 'X' or cells == 'Y'}
  end
  
end

mygame = Game.new
mygame.start
