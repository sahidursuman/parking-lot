require "spec_helper"

describe Car do
	describe '#find_cars_with_colour' do
	    it 'find cars with given colour' do
	    	cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
	      	expect(Car.find_cars_with_colour(cars, "White")).not_to be_empty
	      	expect(Car.find_cars_with_colour(cars, "Red")).to be_empty
	    end
	end

	describe '#find_car_with_registration_number' do
	    it 'find car with given registration number' do
	    	cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
	      	expect(Car.find_car_with_registration_number(cars, "kl-11-z")).to be_kind_of(Object)
	      	expect(Car.find_car_with_registration_number(cars, "kl-11-rr")).to eq(nil)
	    end
	end

	describe '#find_slot' do
	    it 'find slot of a car' do
	    	slots = [Slot.new("1"), Slot.new("2") ]
	    	car = Car.new(1, "kl-11-z", "White")
	    	slots.first.is_available = false
	    	slots.first.car_id = "1"
	      	expect(car.find_slot(slots)).to be_kind_of(Object)
	      	expect(car.find_slot(slots)).to eq(nil)
	    end
	end

	describe '#find_slot' do
	    it 'find slot of a car' do
	    	slots = [ Slot.new("1"), Slot.new(2) ]
			cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
			slots.first.car_id = cars.first.id
	      	expect(Car.find_slots(slots, cars)).not_to be_empty
	    end
	end
end