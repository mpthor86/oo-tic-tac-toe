require 'pry'
class TicTacToe
    def initialize(board = nil)
      @board = board || Array.new(9, " ")
    end
    WIN_COMBINATIONS = [
                        [0,1,2], 
                        [3,4,5],
                        [6,7,8],
                        [6,4,2],
                        [0,4,8],
                        [0,3,6],
                        [1,4,7],
                        [2,5,8]
                        ]
    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end
  
    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    def input_to_index(turn)
        turn = turn.to_i - 1   
    end
    def move(space, player)
        @board[space] = player
    end
    def position_taken?(space)
       @board[space] != " "
    end
    def valid_move?(space)
        if space.between?(0,8) && !position_taken?(space)
            true
        end
    end
    def turn
        input = gets.strip
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
        else gets.strip
        end
        display_board
    end
    def won?
        WIN_COMBINATIONS.any? do |combo| 
          if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
            return combo
          end
        end
    end
    def full?
      @board.all? do |board|
        board != " "
      end
    end
    def draw?
      full? && !won?
    end
    def over?
      won? || draw?
    end
    def winner
      if combo = won?
        @board[combo[0]]
      end
    end
    def play 
      turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
  end 
