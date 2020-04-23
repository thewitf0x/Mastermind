class SecretCode
    attr_reader :code

    def initialize(num)
        @code = generate_code(num)
    end

    def generate_code(num)
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
        colours = ["R","G","B","Y"]
        colour_code = number_code.map { |num| colours[num] }
        colour_code
    end


end