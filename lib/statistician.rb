require_relative './roller'
require 'thread'

class Statistician
    THREAD_LIMIT = 5
    TRIAL_LIMIT = 100
    start_time = Time.now
    
    stat_rolls = []
    trials = []
    max_threads = 0
    threads = Queue.new
    
    
    while threads.size < THREAD_LIMIT do
        new_thread = Thread.new do
            rollers = []
            6.times do
                rollers.push Roller.create([Die.create(6), Die.create(6), Die.create(6), Die.create(6)])
            end
            my_trials = []

            until my_trials.size >= TRIAL_LIMIT.to_f / THREAD_LIMIT
                attempts = 0
                found = false
                    
                until found do 
                    attempts += 1
                    
                    stat_roll = []
                    rollers.each do |roller|
                    
                        stat_roll.push roller.roll_sum(drop: 1, drop_end: :lowest)
                        
                    end
                found = stat_roll.count(18) >= 3
                end
                found = false
                my_trials.push attempts
            end
            trials.concat my_trials
        end
        threads.push(new_thread)
        max_threads = [threads.size, max_threads].max
        puts max_threads
    end

    while threads.size > 0
        threads.pop.join
    end

    puts 'Completed ' + trials.size.to_s + ' trials'
    puts 'Max threads: ' + max_threads.to_s
    puts 'Most attempts: ' + trials.max.to_s
    puts 'Fewest attempts: ' + trials.min.to_s
    puts 'Average attempts: ' + (trials.inject(:+).to_f / trials.size).to_s 
    puts 'Completed in ' + Time.at((Time.new - start_time)).utc.strftime("%H:%M:%S")
end