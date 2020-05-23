require_relative './die.rb'

class Roller
    
    attr_accessor :dice
    attr_accessor :all_rolls

    def self.create(dice)
        Roller.new(dice)
    end
    
    def initialize(dice)
        @dice = dice
        @all_rolls = []
    end

    def roll_sum (**args)
        roll(args).inject(:+)
    end
    
    def all_roll_sums
        result = []
        all_rolls.each do |roll|
            result.push roll.inject(:+)
        end
        result
    end

    def roll (**args)
        result = []
        dice.each do |die|
            result.push die.roll
        end

        if args[:drop_end] == :highest
            args[:drop].times do
                result.delete_at(result.index(result.max))
            end
        elsif args[:drop_end] == :lowest
            args[:drop].times do
                result.delete_at(result.index(result.min))
            end
        end
        all_rolls.push result
        result
    end
end