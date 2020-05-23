class Die
    attr_accessor :sides
    attr_accessor :face_values

    def initialize(number_of_sides)
        @sides = number_of_sides
        @face_values = [*1..number_of_sides]
    end

    def self.create(number_of_sides)
        Die.new(number_of_sides)
    end

    def roll
        face_values.sample
    end
end