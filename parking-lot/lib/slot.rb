load 'lib/car.rb'
class Slot
	attr_accessor :is_available, :number, :car_id

	def initialize(number)
		@number = number
		@is_available = true
	end

	#Function to create slots
	def self.create_slots(lot)
		slots = []
		lot.capacity.to_i.times do |i|
			slots << Slot.new(i + 1)
		end
		slots
	end

	#Function to park a car in corresponding slot
	def park_car(cars, arguments)
		@is_available = false
		car  = Car.new(cars.length + 1, arguments[0], arguments[1])
		@car_id = car.id
		car
	end

	#Function to leave a from corresponding slot
	def leave_car
		@is_available = true
		@car_id = nil
		true
	end

	#Function to find car in given slot
	def find_car(cars)
		cars.each do |car|
			return car if car.id == @car_id
		end
		nil
	end

end