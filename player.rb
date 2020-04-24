require "./game.rb"

class Player
  attr_reader :name
  attr_accessor :tries, :human_code

  def initialize
    @name = get_name()
    @tries = 12
    @human_code = ""
  end

  def get_name
    puts "\n\nWhat's your name?\n\n"
    name = gets.chomp
    name.capitalize
  end

  def get_human_code
    puts "\n\nEnter a code, anywhere from 3 - 9 letters long, using a combination of the letters RGBY:\n\n"
    human_code = gets.chomp
    if valid_human_code?(human_code)
      @human_code = human_code.upcase
    else
      puts "\nI didn't understand that.\n"
      get_human_code()
    end
  end

  def valid_human_code?(human_code)
    colours = ["R", "G", "B", "Y"]
    human_code_array = human_code.split("")
    human_code_array.each { |letter| return false if !colours.include?(letter.upcase) }
    return false if human_code.length < 3 || human_code.length > 9
    true
  end
end