require "./secret_code.rb"
require "./player.rb"
require "./computer.rb"

class Game
  attr_reader :code_length, :player, :computer_player
  attr_accessor :secret_code, :player_guess, :previous_guesses, :code_length, :game_over, :letter_match #remove this line once the game works, it's just for testing

  def initialize(code, num = 4)
    @secret_code = code
    @code_length = num
    @player = Player.new
    @computer_player = ComputerPlayer.new
    @computer_guess = ""
    @player_guess = ""
    @matched_code = ""
    @letter_match = false
    @game_over = false
    @previous_guesses = []
  end

  def guess_code
    if @player.tries > 0
      @player_guess = get_user_guess()
      @player.tries -= 1
      @previous_guesses << @player_guess
      @player_guess
    elsif @player.tries == 0
      lose_game()
    end
  end

  def get_user_guess
    puts "\n\nGuess the #{@code_length} letter code using only the letters RGBY:\n\n"
    user_guess = gets.chomp
    user_guess_array = user_guess.split("")
    if !valid_guess?(user_guess_array)
      puts "\n\nYou can't do that. Try again.\n"
      get_user_guess()
    elsif @previous_guesses.include?(user_guess.upcase)
      puts "\n\nYou already guessed that combination! Try another.\n"
      get_user_guess()
    else
      return user_guess.upcase
    end
  end

  def valid_guess?(guess)
    valid_letters = "RGBYrgby"
    return false if guess.length != @code_length
    guess.each { |letter| return false if !valid_letters.include?(letter) }
    true
  end

  def lose_game
    @game_over = true
    puts "\n\nNo more guesses. YOU LOSE. The code was #{@secret_code}."
  end

  def check_code
    return you_win() if @player_guess == @secret_code
    if @player.tries > 0
      give_feedback(@player_guess) if partial_match?(@player_guess)
      puts "\nYou have #{@player.tries} remaining guess(es).\n\n"
    else
      lose_game()
    end
  end

  def check_computer_code
    @computer_guess = @computer_player.computer_guess
    return computer_loses() if @computer_player.tries == 0
    return computer_wins() if @computer_guess == @secret_code
    give_computer_feedback(@computer_guess) if partial_match?(@computer_guess)
  end

  def partial_match?(code)
    guess = code.split("")
    guess.each { |letter| return true if @secret_code.include?(letter) }
    false
  end

  def give_feedback(guess)
    right_colour_and_pos(guess)
    right_colour_wrong_pos(guess) if !@letter_match
    @letter_match = false
  end

  def give_computer_feedback(guess)
    computer_colour_and_pos(guess)
    computer_colour_wrong_pos(guess) if !@letter_match
  end

  def computer_colour_and_pos(guess)
    matched = []
    show_partial_match = false

    (0...@code_length).each do |idx|
      if guess[idx] == @secret_code[idx]
        correct_letter = guess[idx]
        matched << correct_letter
        @letter_match = true
        show_partial_match = true
      else
        matched << "*"
      end
    end
    @matched_code = matched.join("")
    @computer_player.partial_match = @matched_code
    puts "\n\nThe computer's guess partially matches, #{@player.name}!\n\n\t#{@matched_code}\n" if show_partial_match
  end

  def computer_colour_wrong_pos(guess)
    matched = []
    guess.each_char.with_index do |guessed_letter, guess_idx|
      @secret_code.each_char.with_index do |coded_letter, code_idx|
        if guessed_letter == coded_letter && !matched.include?(guessed_letter)
          matched << guessed_letter
        end
      end
    end
    @computer_player.confirmed_colours = matched
    @computer_player.right_colour = true
    puts "\nThe computer has realised your code definitely includes the colour(s): #{matched.join("")}"
  end

  def right_colour_and_pos(guess)
    matched = []
    show_partial_match = false

    (0...@code_length).each do |idx|
      if guess[idx] == @secret_code[idx]
        correct_letter = guess[idx]
        matched << correct_letter
        @letter_match = true
        show_partial_match = true
      else
        matched << "*"
      end
    end
    @matched_code = matched.join("")
    puts "\n\nYour code partially matches, #{@player.name}!\n\n\t#{@matched_code}" if show_partial_match
  end

  def right_colour_wrong_pos(guess)
    matched = []
    guess.each_char.with_index do |guessed_letter, guess_idx|
      @secret_code.each_char.with_index do |coded_letter, code_idx|
        if guessed_letter == coded_letter && !matched.include?(guessed_letter)
          matched << guessed_letter
        end
      end
    end
    puts "\n\nClose! The secret code definitely includes the colour(s): #{matched.join("")}"
  end

  def you_win()
    @game_over = true
    if @player.tries <= 2
      puts "\n\nYou got it right! You scraped a WIN by the skin of your teeth! The code was #{@secret_code}.\n\n"
    elsif @player.tries <= 4
      puts "\n\nFinally you got it right. I thought you weren't going to make it. The code was #{@secret_code}. YOU WIN!\n\n"
    elsif @player.tries <= 7
      puts "\n\nA confident WIN. Well done! The code was #{@secret_code}.\n\n"
    else
      puts "\n\nYou WIN with hardly any guesses used! That must have been a FLUKE! But you were right, the code was #{@secret_code}.\n\n"
    end
  end

  def computer_wins
    @game_over = true
    puts "\n\nThe computer guessed your code and wins!\n\n"
  end

  def computer_loses
    @game_over = true
    puts "\n\nThe computer failed to guess your code and loses! You win!\n\n"
  end
end
