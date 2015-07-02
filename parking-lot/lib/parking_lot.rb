load 'lib/slot.rb'

WRONG_ARGUMENT_MESSAGE = "Invalid arguments"

class ParkingLot
	attr_accessor :capacity

	def initialize(capacity)
		@capacity = capacity
	end

	def self.create_parking_lot(arguments)
		if arguments.length == 1 && (arguments.first =~ /\A\d+\z/ ? true : false)
			lot = ParkingLot.new(arguments.first)
			puts "\nCreated a parking lot with #{arguments.first} slots"
			lot
		else
			puts WRONG_ARGUMENT_MESSAGE
		end
	end

	#Function to park inside a lot
	def park(slots, cars, arguments)
		return WRONG_ARGUMENT_MESSAGE if invalid_arguments?(arguments, 2)
		slots.each do |slot|
			if slot.is_available
				cars << slot.park_car(cars, arguments)
				return "Allocated slot number: #{slot.number}"
			end
		end
		return "Sorry, parking lot is full"
	end

	#Function to leave a car from lot
	def leave(slots, cars, arguments)
		return WRONG_ARGUMENT_MESSAGE if invalid_arguments?(arguments, 1)
		slots.each do |slot|
			if slot.number == arguments.first.to_i
				slot.leave_car
				return "Slot number #{slot.number} is free"
			end
		end
		nil
	end

	#Function to print lot's current status
	def status(slots, cars, arguments)
		return WRONG_ARGUMENT_MESSAGE if invalid_arguments?(arguments, 0)
		puts "\nSlot No.	Registration No		Colour"
		slots.each do |slot|
			cars.each do |car|
				if car.id == slot.car_id
					puts "#{slot.number}		#{car.registration_number}		#{car.colour}"
					break
				end
			end
		end
		nil
	end

	def registration_numbers_for_cars_with_colour(slots, cars, arguments)
		return WRONG_ARGUMENT_MESSAGE if invalid_arguments?(arguments, 1)
		cars_in_lot = find_cars_in_lot(slots, cars)
		cars_with_given_colour = Car.find_cars_with_colour(cars_in_lot, arguments.first)
		cars_with_given_colour.any? ? cars_with_given_colour.map(&:registration_number).join(", ") : "No cars with colour #{arguments.first}"
	end

	def slot_numbers_for_cars_with_colour(slots, cars, arguments)
		return WRONG_ARGUMENT_MESSAGE if invalid_arguments?(arguments, 1)
		cars_with_given_colour = Car.find_cars_with_colour(cars, arguments.first)
		cars_with_given_colour.any? ? slots_for_cars_with_colour = Car.find_slots(slots, cars_with_given_colour) : slots_for_cars_with_colour = []
		slots_for_cars_with_colour.any? ? slots_for_cars_with_colour.map(&:number).join(", ") : "No cars with colour #{arguments.first}"
	end

	def slot_number_for_registration_number(slots, cars, arguments)
		return WRONG_ARGUMENT_MESSAGE if invalid_arguments?(arguments, 1)
		car = Car.find_car_with_registration_number(cars, arguments[0])
		car ? slot = car.find_slot(slots) : slot = nil
		slot ? slot.number : "No Car with Registration Number #{arguments[0]}"
	end

	private

	#Function to find car in lot
	def find_cars_in_lot(slots, cars)
		cars_from_slots = []
		slots.each do |slot|
			cars_from_slots << slot.find_car(cars)
		end
		cars_from_slots.compact
	end

	#Function to check if arguments are valid or not
	def invalid_arguments?(arguments, count)
		arguments.length != count
	end

end
