class TicTacToe
  def initialize(board = nil)
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts " #{@board[0]} " + '|' + " #{@board[1]} " + '|' + " #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} " + '|' + " #{@board[4]} " + '|' + " #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} " + '|' + " #{@board[7]} " + '|' + " #{@board[8]} "
  end

  WIN_COMBINATIONS = [
    [0, 1, 2], # top row
    [3, 4, 5], # middle row
    [6, 7, 8], # bottom row
    [0, 3, 6], # left column
    [1, 4, 7], # middle column
    [2, 5, 8], # right column
    [0, 4, 8], # left diagonal
    [2, 4, 6]  # right diagona
  ]

  def move(position, value)
    @board[position.to_i - 1] = value
  end

  def position_taken?(position)
    !(@board[position] == " ")
  end

  def valid_move?(position)
    position.to_i.between?(1,9) &&
    !position_taken?(position.to_i - 1)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
      if valid_move?(input)
        value = current_player
        move(input, value)
        display_board
      else
      turn
    end
  end

  def turn_count
    9 - @board.count(" ")
  end

  def current_player
    turn_count.odd? ? "O" : "X" # using ternary if
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|

      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X" ||
        position_1 == "O" && position_2 == "O" && position_3 == "O"
         return win_combination
      end
    end

    @board.all? do |member|
      if member.eql?(" ")
        false
      end
    end
  end

  def full?
    @board.all? do |member|
      member.eql?("X") || member.eql?("O")
    end
  end

  def draw?
     !won? && full?
  end

  def over?
    won? || draw? || full?
  end

  def winner
    win = won?

    if !win
      nil
    else
      @board[win[0]]
    end
  end

  def play
    until over?
      turn
    end
    you_win = winner
    win = won?
    draw = draw?
    if win
      puts "Congratulations #{you_win}!"
    else draw
      puts "Cats Game!"
    end
  end



end
