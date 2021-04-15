require './lib/ride'
require './lib/attendee'
require './lib/carnival'

RSpec.describe Carnival do

    before do
        @jeffco_fair = Carnival.new('Jefferson County Fair')
        @ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
        @bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
        @scrambler = Ride.new({name: 'Scrambler', cost: 15})
    end

    describe '#initialize' do
        it 'exists' do
            expect(@jeffco_fair).to be_instance_of(Carnival)
        end
        it 'has attributes' do
            expect(@jeffco_fair.name).to eq('Jefferson County Fair')
            expect(@jeffco_fair.rides).to eq([])
        end
    end
    describe '#add_ride' do
        it 'allows you to add rides' do
            @jeffco_fair.add_ride(@ferris_wheel)
            @jeffco_fair.add_ride(@bumper_cars)
            @jeffco_fair.add_ride(@scrambler)
            expect(@jeffco_fair.rides).to eq([@ferris_wheel, @bumper_cars, @scrambler])
        end
    end
    describe '#recommend_rides' do
        it 'recommends rides to specific attendees' do
            bob = Attendee.new('Bob', 20)
            sally = Attendee.new('Sally', 20)
            @jeffco_fair.add_ride(@ferris_wheel)
            @jeffco_fair.add_ride(@bumper_cars)
            @jeffco_fair.add_ride(@scrambler)
            bob.add_interest('Ferris Wheel')
            bob.add_interest('Bumper Cars')
            sally.add_interest('Scrambler')
            expect(@jeffco_fair.recommend_rides(bob)).to eq([@ferris_wheel, @bumper_cars])
            expect(@jeffco_fair.recommend_rides(sally)).to eq([@scrambler])
        end
    end
    describe '#admit' do
        it 'allows you to admit attendees to the park' do
            @jeffco_fair.add_ride(@ferris_wheel)
            @jeffco_fair.add_ride(@bumper_cars)
            @jeffco_fair.add_ride(@scrambler)
            bob = Attendee.new('Bob', 20)
            sally = Attendee.new('Sally', 20)
            johnny = Attendee.new("Johnny", 5)
            bob.add_interest('Ferris Wheel')
            bob.add_interest('Bumper Cars')
            sally.add_interest('Scrambler')
            johnny.add_interest('Bumper Cars')
            @jeffco_fair.admit(bob)
            @jeffco_fair.admit(sally)
            @jeffco_fair.admit(johnny)
            expect(@jeffco_fair.attendees).to eq([bob, sally, johnny])
        end
    end
    describe '#attendees_by_ride_interest' do
        it 'creates a hash to display attendees by ride interest' do
            @jeffco_fair.add_ride(@ferris_wheel)
            @jeffco_fair.add_ride(@bumper_cars)
            @jeffco_fair.add_ride(@scrambler)
            bob = Attendee.new('Bob', 20)
            sally = Attendee.new('Sally', 20)
            johnny = Attendee.new("Johnny", 5)
            bob.add_interest('Ferris Wheel')
            bob.add_interest('Bumper Cars')
            sally.add_interest('Scrambler')
            johnny.add_interest('Bumper Cars')
            @jeffco_fair.admit(bob)
            @jeffco_fair.admit(sally)
            @jeffco_fair.admit(johnny)
            expect(@jeffco_fair.attendees_by_ride_interest).to eq({@ferris_wheel => [bob], 
                                                                   @bumper_cars => [bob, johnny],
                                                                   @scrambler => [sally]})
        end
    end
    describe '#attendees_interested_in_ride' do
        it 'tells you which attendees are interested in a given ride' do
            @jeffco_fair.add_ride(@bumper_cars)
            bob = Attendee.new('Bob', 20)
            johnny = Attendee.new("Johnny", 5)
            bob.add_interest('Bumper Cars')
            johnny.add_interest('Bumper Cars')
            @jeffco_fair.admit(bob)
            @jeffco_fair.admit(johnny)
            expect(@jeffco_fair.attendees_interested_in_ride(@bumper_cars)).to eq([bob, johnny])
        end
    end
    describe '#ticket_lottery_contestants' do
        it 'creates lottery contestants for a free ride ticket' do
            @jeffco_fair.add_ride(@bumper_cars)
            bob = Attendee.new('Bob', 20)
            johnny = Attendee.new("Johnny", 5)
            bob.add_interest('Bumper Cars')
            johnny.add_interest('Bumper Cars')
            @jeffco_fair.admit(bob)
            @jeffco_fair.admit(johnny)
            expect(@jeffco_fair.ticket_lottery_contestants(@bumper_cars)).to eq([bob, johnny])
        end
    end
    describe '#draw_lottery_winner' do
        it 'picks a random winner from lottery contestants for a free ride ticket' do
            @jeffco_fair.add_ride(@bumper_cars)
            bob = Attendee.new('Bob', 20)
            johnny = Attendee.new("Johnny", 5)
            bob.add_interest('Bumper Cars')
            johnny.add_interest('Bumper Cars')
            @jeffco_fair.admit(bob)
            @jeffco_fair.admit(johnny)
            expect(@jeffco_fair.draw_lottery_winner(@bumper_cars)).to be_instance_of(Attendee)
            expect(@jeffco_fair.draw_lottery_winner(@bumper_cars)).to eq(bob).or(eq(johnny))
        end
    end    
    describe '#announce_lottery_winner' do
        it 'announces the lottery winner' do
            @jeffco_fair.add_ride(@bumper_cars)
            bob = Attendee.new('Bob', 20)
            johnny = Attendee.new("Johnny", 5)
            bob.add_interest('Bumper Cars')
            johnny.add_interest('Bumper Cars')
            @jeffco_fair.admit(bob)
            @jeffco_fair.admit(johnny)
            ##struggling with my stub - will return to this later if I have finished Iteration 4
            # stub = double('attendee')
            # allow(stub).to receive(:name) {'Bob'}

            # require 'pry'; binding.pry
            # expect(expect(@jeffco_fair.stub(:response).and_return("Bob has won the IMAX exhibit")
            expect(@jeffco_fair.announce_lottery_winner(@ferris_wheel)).to eq("No winners for this lottery")
        end
    end
    describe '#attendees_of_rides' do
        it 'announces the lottery winner' do
            @jeffco_fair.add_ride(@ferris_wheel)
            @jeffco_fair.add_ride(@bumper_cars)
            @jeffco_fair.add_ride(@scrambler)
            tj = Attendee.new('TJ', 7)
            tj.add_interest('Scrambler')
            tj.add_interest('Bumper Cars')
            @jeffco_fair.admit(tj)
            expect(@jeffco_fair.attendees_of_rides).to eq({})
            expect(@jeffco_fair.revenue).to eq(0)
            expect(tj.spending_money).to eq (7)
            bob = Attendee.new('Bob', 10)
            bob.add_interest('Bumper Cars')
            bob.add_interest('Scrambler')
            @jeffco_fair.admit(bob)
            expect(@jeffco_fair.attendees_of_rides).to eq({bumper_cars => bob})
            expect(@jeffco_fair.revenue).to eq(10)
            expect(bob.spending_money).to eq(0)
        end
    end
end