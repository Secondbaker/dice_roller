require_relative './roller'

class Statistician
    rollers = []
    stat_rolls = []
    trials = []
    6.times do
        rollers.push Roller.create([Die.create(6), Die.create(6), Die.create(6), Die.create(6)])
    end
    
    found = false
    1000.times do
        attempts = 0
        until found do 
            attempts += 1
            
            stat_roll = []
            rollers.each do |roller|
            
                stat_roll.push roller.roll_sum(drop: 1, drop_end: :lowest)
                
            end
        found = stat_roll.count(18) >= 4
        end
        found = false
        trials.push attempts
        puts 'Trial number: ' + trials.size.to_s
    end
    puts 'Most attempts: ' + trials.max.to_s
    puts 'Fewest attempts: ' + trials.min.to_s
    puts 'Average attempts: ' + (trials.inject(:+).to_f / trials.size).to_s 
end