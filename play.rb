require "./game.rb"
require "./player.rb"
require "./computer.rb"

def get_length
  length_of_code = gets.chomp.to_i
  length_of_code
end

def valid_input?(input)
  return true if input.is_a?(Integer) && input < 10 && input > 2
  false
end

def lets_play
  print "\n\nLET'S PLAY MASTERMIND\n\n"
  print "\nHow long do you want the secret code to be? The longer, the harder. You will always only have 12 guesses! Enter a number from 3-9:\n\n"
  length_of_code = get_length()
  if valid_input?(length_of_code)
    game = Game.new("", length_of_code) #creates new game without secret code
    game.secret_code = SecretCode.new(length_of_code).code #computer generates secret code
    until game.game_over
      game.guess_code
      game.check_code
    end
  else
    lets_play()
  end
end

def computer_or_human()
  puts "\n\nWould you like to guess the code, or create a code for the computer to guess? (GUESS/ CREATE)\n\n"
  answer = gets.chomp
  if answer.upcase == "GUESS"
    lets_play()
  elsif answer.upcase == "CREATE"
    computer_plays()
  else
    puts "\nI didn't understand that.\n"
    computer_or_human()
  end
end

def computer_plays
  game = Game.new("")
  human_code = game.player.get_human_code()
  game.secret_code = human_code
  game.code_length = human_code.length
  until game.game_over
    game.computer_player.guess_code(game.code_length)
    game.check_computer_code
  end
end

def play_again
  play_again = gets.chomp

  if play_again.upcase == "Y"
    computer_or_human()
    print "\n\nDo you want to play again? Y/N\n\n"
    play_again()
  else
    puts "\nThanks for playing.\n"
    return false
  end
end

computer_or_human()

print "\n\nDo you want to play again? Y/N\n\n"
play_again()


