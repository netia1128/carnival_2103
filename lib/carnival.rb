require_relative 'attendee'
require_relative 'ride'

class Carnival
    attr_reader :name,
                :rides,
                :attendees

    def initialize(name)
        @name = name
        @rides = []
        @attendees = []
    end

    def add_ride(ride)
        @rides << ride
    end

    def recommend_rides(attendee)
        @rides.find_all do |ride|
            attendee.interests.include?(ride.name)
        end
    end

    def admit(attendee)
        @attendees << attendee
    end

    def attendees_by_ride_interest
        @rides.each_with_object({}) do |ride, hash|
            hash[ride] = attendees_interested_in_ride(ride)
        end
    end

    def attendees_interested_in_ride(ride)
        attendees.find_all do |attendee|
            attendee.interests.include?(ride.name)
        end
    end

    def ticket_lottery_contestants(ride)
        attendees_interested_in_ride(ride)
    end

    def draw_lottery_winner(ride)
        ticket_lottery_contestants(ride).sample
    end

    def announce_lottery_winner(ride)
        if draw_lottery_winner(ride).nil?
            "No winners for this lottery"
        else
            "#{draw_lottery_winner(ride)} has won the #{ride.name} ticket."
        end
    end
end