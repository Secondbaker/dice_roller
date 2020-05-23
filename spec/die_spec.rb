require_relative '../lib/die.rb'

describe Die do
    
    context 'initializing' do
        it 'has a known number of sides' do
            die = Die.create(6)
            expect(die.sides).to eq 6
        end
        it 'has the correct values for its sides' do
            die = Die.create(10)
            expect(die.face_values).to eq [*1..10]
        end
    end
    context 'rolling' do
        it 'produces a number' do
            die = Die.create(6)
            expect(die.roll).to_not be nil
        end
    end
end