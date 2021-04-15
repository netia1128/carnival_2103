require './lib/ride'
require './lib/attendee'
require './lib/carnival'

RSpec.describe Carnival do

    before do
        @carnival = carnival.new('Jefferson County Fair')
    end

    describe '#initialize' do
        it 'exists' do
            expect(@carnival).to be_instance_of(Carnival)
        end
        it 'has attributes' do
            expect(@carnival.name).to eq('Jefferson County Fair')
            expect(@carnival.rides).to eq([])
        end
    end
end