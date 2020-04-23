require "./game.rb"

class Player
    attr_reader :name
    attr_accessor :tries

    def initialize
        @name = get_name()
        @tries = 12
    end

    def get_name
        puts "\n\nWhat's your name?\n\n"
        name = gets.chomp
        name.capitalize
    end

end