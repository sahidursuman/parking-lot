class Car
	attr_accessor :id, :registration_number, :colour
	def initialize(id, registration_number, colour)
		@registration_number = registration_number
		@colour = colour
		@id = id
	end

	#Function to find cars with given colour
	def self.find_cars_with_colour(cars, colour)
		cars_with_given_colour = [] 
		cars.each do |car|
		    cars_with_given_colour << car if car.colour == colour
		end
		cars_with_given_colour
	end

	#Function to find cars with given registration number
	def self.find_car_with_registration_number(cars, registration_number)
		cars.each do |car|
		    return car if car.registration_number == registration_number
		end
		nil
	end

	#Function to find slot of a car
	def find_slot(slots)
		slots.each do |slot|
			return slot if slot.car_id == @id
		end
		nil
	end

	#Function to find slots of cars 
	def self.find_slots(slots, cars)
		slots_for_cars = []
		cars.each do |car|
			slots_for_cars << car.find_slot(slots)
		end
		slots_for_cars.compact
	end
end