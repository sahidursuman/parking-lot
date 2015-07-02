require "spec_helper"

describe Slot do
	describe '#create_slots' do
	    it 'create slots for a parking lot' do
	      expect(Slot.create_slots(ParkingLot.new("5"))).not_to be_empty
	    end
	end

	describe '#park_car' do
	    it 'Park car into a slot' do
	    	cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
	      	expect(Slot.new("1").park_car(cars, ["kl-11-z", "White"])).to be_kind_of(Object)
	    end
	end

	describe '#leave_car' do
	    it 'Leave car from a slot' do
	    	slot = Slot.new("1")
	    	slot.is_available = false
	    	slot.car_id = "1"
	      	expect(slot.leave_car).to eq(true)
	    end
	end

	describe '#find_car' do
	    it 'Find car in a slot' do
	    	slots = [ Slot.new("1"), Slot.new(2) ]
			cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
			slots.first.car_id = cars.first.id
	      	expect(slots.first.find_car(cars)).to be_kind_of(Object)
	      	expect(slots.last.find_car(cars)).to eq(nil)
	    end
	end
end