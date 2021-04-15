require_relative 'attendee'
require_relative 'ride'

class Carnival
    attr_reader :name,
                :rides,
                :attendees,
                :revenue,
                :attendees_of_rides

    def initialize(name)
        @name = name
        @rides = []
        @attendees = []
        @revenue = 0
        attendees_of_rides = {}
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
        take_rides(attendee)
    end

    def take_rides(attendee)
        rides_interested_in = []
        require 'pry'; binding.pry
                attendee.interests.each do |interest|
            if attendee.interest == rides.each do |ride|
                ride.name
            end
                rides_interested_in << ride
            end
        end

        #not going to finish, but here is what I would have done
            # iterate through attendees interests and within that iteration, iterate through carnival rides
            # make an array of all ride objects that match an attendee interest
            # sort ride objects by price
            # iterate through sorted ride objects and see if attendee spending money >= ride price
            # if so, the attendee will take that ride
            #     this means the ride gets pushed into the attendees of ride hash as a key
            #     the attendees spending money is decreased by the cost of the ride (method update_attendee_spending_money)
            #     the carnival revenue increases by the cost of the ride (method update_revenue)
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