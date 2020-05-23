require_relative './roller'
require 'thread'

class Statistician
    start_time = Time.now
    rollers = []
    stat_rolls = []
    trials = []
    max_threads = 0
    threads = Queue.new
    6.times do
        rollers.push Roller.create([Die.create(6), Die.create(6), Die.create(6), Die.create(6)])
    end
    
    until trials.size >= 1000 do
        if threads.size < 1000
            new_thread = Thread.new do
                attempts = 0
            found = false
                
            until found do 
                attempts += 1
                
                stat_roll = []
                rollers.each do |roller|
                
                    stat_roll.push roller.roll_sum(drop: 1, drop_end: :lowest)
                    
                end
            found = stat_roll.count(18) >= 2
            end
            found = false
            trials.push attempts
            end
            threads.push new_thread
        else
            threads.pop.join
        end
        max_threads = [threads.size, max_threads].max
    end

    puts 'Completed ' + trials.size.to_s + ' trials'
    puts 'Max threads: ' + max_threads.to_s
    puts 'Most attempts: ' + trials.max.to_s
    puts 'Fewest attempts: ' + trials.min.to_s
    puts 'Average attempts: ' + (trials.inject(:+).to_f / trials.size).to_s 
    puts 'Completed in ' + Time.at((Time.new - start_time)).utc.strftime("%H:%M:%S")
end