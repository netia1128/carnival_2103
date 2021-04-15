require './lib/attendee'

RSpec.describe Attendee do

    before do
        @attendee = Attendee.new('Bob', 20)
    end

    describe '#initialize' do
        it 'exists' do
            expect(@attendee).to be_instance_of(Attendee)
        end
        it 'has attributes' do
            expect(@attendee.name).to eq('Bob')
            expect(@attendee.spending_money).to eq(20)
            expect(@attendee.interests).to eq([])
        end
    end
    describe '#add_interests' do
        it 'allows you to add interests' do
            @attendee.add_interest('Bumper Cars')
            @attendee.add_interest('Ferris Wheel')
            expect(@attendee.interests).to eq(['Bumper Cars', 'Ferris Wheel'])
        end
    end
end