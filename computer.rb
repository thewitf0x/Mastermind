require 'byebug'
require './game.rb'

class ComputerPlayer
    attr_reader :computer_guess, :tries
    attr_accessor :partial_match, :previous_guesses, :confirmed_colours, :right_colour

    def initialize
        @name = "Computer"
        @tries = 6
        @computer_guess = ""
        @partial_match = ""
        @right_colour = false
        @confirmed_colours = []
        @previous_guesses = []
    end

    def guess_code(num)
        @tries -= 1
        @computer_guess = generate_code(num)
        @previous_guesses << @computer_guess
        puts "\n\nThe computer guessed #{computer_guess}. #{@tries} guess(es) remaining.\n\n"
    end

    def generate_code(num) #this one generates any code
        if @right_colour
            @right_colour = false
            guess_including_colour(num) #this one should guess a code including a specific colour
        elsif @partial_match == ""
            generate_fresh_code(num) #this one generates totally fresh random code
        else
            guess_including_partial_match() #this one guesses code including partial match
        end
    end

    def guess_including_colour(num)
        colours = @confirmed_colours
        guess_with_colours = []

        num.times do
            random_colour = colours[rand(0...colours.length)]
            guess_with_colours << random_colour
        end

        guess_with_colours.join("")
    end

    def guess_including_partial_match
        letters = ["R","G","B","Y"]
        partial_array = @partial_match.split("")
        partial_guess = []

        partial_array.each do |letter|
            if letters.include?(letter)
                partial_guess << letter
            else
                partial_guess << letters[rand(0..3)]
            end
        end
        partial_guess.join("")
    end

    def check_previous_guesses(num)
        if @previous_guesses.include?(@computer_guess)
            guess_fresh_code(num)
        end
    end

    def generate_fresh_code(num) #this one specifically generates a new code, ie. not including previous partial matches
      number_code = generate_number_code(num)
      generate_colour_code(number_code).join()
    end

    def generate_number_code(num)
        final_code = []
            while final_code.length < num
                final_code << rand(0..3)
            end
        final_code
    end

    def generate_colour_code(number_code)
        colours = ["R", "G", "B", "Y"]
        colour_code = number_code.map { |num| colours[num] }
        colour_code
    end

end