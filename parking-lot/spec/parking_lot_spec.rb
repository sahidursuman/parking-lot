require "spec_helper"

describe ParkingLot do

  describe '#create_parking_lot' do
    it 'create new ParkingLot' do
      expect(ParkingLot.create_parking_lot(["6"])).not_to be_nil
    end
  end

  describe '#park' do
    it 'Park car' do
      slots = Slot.create_slots(lot = ParkingLot.new("6"))
      cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
      expect(lot.park(slots, cars, ["kl-11-z", "White"])).to be_kind_of(String)
    end
  end

  describe '#leave' do
    it 'Leave car from slot' do
      slots = Slot.create_slots(lot = ParkingLot.new("6"))
      cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
      slots.first.car_id = cars.first.registration_number
      expect(lot.leave(slots, cars, [slots.first.number])).to eq("Slot number #{slots.first.number} is free")
    end
  end
  
  
  describe '#registration_numbers_for_cars_with_colour' do
    it 'to find registration numbers of cars with given colour' do
      slots = Slot.create_slots(lot = ParkingLot.new("6"))
      cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
      slots.first.car_id = cars.first.id
      expect(lot.registration_numbers_for_cars_with_colour(slots, cars, ["White"])).to eq("kl-11-z")
      expect(lot.registration_numbers_for_cars_with_colour(slots, cars, ["Red"])).to eq("No cars with colour Red")
    end
  end

  describe '#slot_numbers_for_cars_with_colour' do
    it 'to find slot numbers of cars with given colour' do
      slots = Slot.create_slots(lot = ParkingLot.new("6"))
      cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
      slots.first.car_id = cars.first.id
      expect(lot.slot_numbers_for_cars_with_colour(slots, cars, ["White"])).to eq("1")
      expect(lot.slot_numbers_for_cars_with_colour(slots, cars, ["Red"])).to eq("No cars with colour Red")
    end
  end

  describe '#slot_number_for_registration_number' do
    it 'to find slot number of car with given registration number' do
      slots = Slot.create_slots(lot = ParkingLot.new("6"))
      cars = [Car.new(1, "kl-11-z", "White"), Car.new(2, "kl-22-e", "Black")]
      slots.first.car_id = cars.first.id
      expect(lot.slot_number_for_registration_number(slots, cars, ["kl-11-z"])).to eq(1)
      expect(lot.slot_number_for_registration_number(slots, cars, ["kl-11-rr"])).to eq("No Car with Registration Number kl-11-rr")
    end
  end

end
