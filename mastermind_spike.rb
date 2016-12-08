
# Classes
#------------------------#
# Player
# - Codemaker
# - Codebreaker
#
# Board
# - Code_holes
# - Scoring_holes
#
# Code_pegs
# - red
# - blue
# - green
# - yellow
# - white
# - black
#
# Scoring_pegs
# - white
# - black

class Codemaker
  # name
  # score
  # code
end

class Codebreaker
  # name
  # score
end

class Board
  # code_holes
  # scoring_holes
  def draw
    draw = <<-DRAW
    +---+---+---+---+
    | R | B | G | Y |
    |---+---+---+---|
    |   |   |   |   |
    |---+---+---+---|
    |   |   |   |   |
    |---+---+---+---|
    |   |   |   |   |
    |---+---+---+---|
    |   |   |   |   |
    |---+---+---+---|
    |   |   |   |   |
    |---+---+---+---|
    |   |   |   |   |
    |---+---+---+---|
    |   |   |   |   |
    +---+---+---+---+
    DRAW
    puts draw
  end
end

class Code_peg
  # color
end

class Scoring_peg
  # color
end

class Game
  def initialize
    @board = Board.new
  end

  def play
    display_board
  end

  def display_board
    @board.draw
  end
end

game = Game.new
game.play
