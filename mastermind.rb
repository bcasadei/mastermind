# Codemaker class: computer name, generates random code
class Codemaker
  attr_reader :code, :name

  def initialize
    @name = 'The Keymaster'
    @code = create_code
  end

  def create_code
    pegs = %w(R B G Y O P)
    code = []
    4.times { code << pegs.sample }
    code
  end
end

# Codebreaker class: player name
class Codebreaker
  attr_reader :name

  def initialize
    enter_name
  end

  def enter_name
    loop do
      puts 'Enter your name to continue.'
      @name = gets.chomp
      break unless @name.empty?
      puts 'You have to enter a name to continue!'
    end
  end
end

# Board class: displays game board, player choices and score
class Board
  attr_accessor :choices, :turns, :feedback

  def initialize(turns)
    reset(turns)
  end

  def draw
    closing_line = ' +---+---+---+---+ '
    empty_row = ' |   |   |   |   | '
    rows = turns - choices.size

    puts closing_line
    rows.times do
      puts empty_row
      puts closing_line
    end

    counter = 0
    while counter < choices.size
      puts ' | ' + choices[counter].join(' | ') + ' | ' \
      + feedback[counter].join(' ')
      puts closing_line
      counter += 1
    end
  end

  def reset(turns = 12)
    @choices = []
    @turns = turns
    @feedback = []
  end
end

# Game class: Contains game loop and game logic
class Game
  attr_accessor :board

  def initialize
    @board = Board.new(12)
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
  end

  def game_over?
    board.choices.size >= board.turns || winner?
  end

  def who_won
    if board.choices.size >= board.turns
      codemaker_wins
    elsif winner?
      codebreaker_wins
    end
  end

  def play
    loop do
      clear
      welcome_message
      display_board
      generate_code
      loop do
        player_turn
        score_turn
        display_board
        break if game_over?
      end
      who_won
      break unless play_again?
      reset
    end
  end

  def clear
    system 'clear'
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def welcome_message
    prompt "Welcome to Mastermind #{@codebreaker.name}."
    prompt "I am #{@codemaker.name}. Try and guess my code!"
  end

  def display_board
    @board.draw
  end

  def generate_code
    @codemaker.create_code
  end

  def codemaker_wins
    prompt 'Sorry, you have run out of turns. Keymaster wins!'
  end

  def codebreaker_wins
    prompt 'Congratulations, you won!'
    prompt "The code was #{@codemaker.code.join(' ')}."
  end

  def display_instructions
    prompt 'Enter 4 letters: R B G Y O or P.'
    prompt 'Letters can be repeated in the code.'
  end

  def play_again?
    answer = nil
    loop do
      prompt 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      prompt 'Sorry, must be y or n.'
    end

    answer == 'y'
  end

  def reset
    board.reset
    clear
  end

  def player_turn
    @guess = ''
    loop do
      display_instructions
      @guess = gets.chomp.to_s.upcase.gsub(/\s+/, '')
      break if @guess =~ /[RBGYOP]/ && @guess.length == 4
      prompt 'Try again. Enter 4 letters: R B G Y O or P.'
    end
    board.choices.unshift(@guess.split(''))
  end

  def winner?
    @score == %w(x x x x)
  end

  def score_turn
    p code = @codemaker.code
    @score = [nil, nil, nil, nil]

    code.each_with_index { |char, i| @score[i] = 'x' if @guess[i] == char }

    code.each_with_index do |char, i|
      @score[i] = 'o' if @guess.include?(char) && @score[i].nil?
    end

    board.feedback.unshift(@score.compact)
  end
end

game = Game.new
game.play
