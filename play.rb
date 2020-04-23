require "./game.rb"
require 'byebug'

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
        game = Game.new(length_of_code)
        until game.game_over
            game.guess_code
            game.check_code
        end
    else
        lets_play()
    end
end

lets_play()

print "\n\nDo you want to play again? Y/N\n\n"
play_again = gets.chomp

if play_again.upcase == "Y"
    lets_play()
else
    puts "Thanks for playing."
    return false
end
