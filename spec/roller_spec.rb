require_relative '../lib/die'
require_relative '../lib/roller'

describe Roller do
    subject { Roller.create([Die.create(6), Die.create(6), Die.create(6)]) }
    context 'initializing a roller' do
        it 'with dice' do
            die = Die.create(6)
            subject = Roller.create([die, die, die])
            expect(subject.dice.size).to eq 3
        end
    end
    context 'rolling dice' do
        it 'produces a number when rolling a sum' do
            expect(subject.roll_sum).to be_an(Integer)
        end
        
        it 'produces an array when rolling values' do
            expect(subject.roll).to be_an(Array)
        end

        it 'can drop n lowest values' do
            expect(subject.roll(drop_end: :lowest, drop: 1).size).to eq 2
        end
        it 'can drop n highest values' do
            roll = subject.roll(drop_end: :highest, drop: 1)
            expect(roll.size).to eq 2
        end
        it 'can return an array of all rolls' do
            10.times do 
                subject.roll
            end
            expect(subject.all_rolls.size).to eq 10
        end
        it 'can return an array of all roll sums' do
            10.times do 
                subject.roll
            end
            expect(subject.all_roll_sums.size).to eq 10
        end
        it 'doesn\'t mess up rolls by calulating roll sums' do
            10.times do 
                subject.roll
            end
            subject.all_roll_sums
            expect(subject.all_rolls.first.size).to eq 3
        end
    end
end