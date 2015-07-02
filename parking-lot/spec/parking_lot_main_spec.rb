require "spec_helper"

describe ParkingLotMain do

  describe '#is_file_input?' do
    it 'Check whether input is in file format or not' do
      expect(ParkingLotMain.new.is_file_input?(["resources/input.txt"])).to eq(true)
      expect(ParkingLotMain.new.is_file_input?([])).to eq(false)
    end
  end

  describe 'extract_commands_from_input_file' do
    it 'extract commands from input file' do
      expect(ParkingLotMain.new.extract_commands_from_input_file(["resources/input.txt"])).to be_kind_of(Array)
    end
  end

  describe 'extract_command_from_line' do
    it 'extract commands from string' do
      expect(ParkingLotMain.new.extract_command_from_line("command number color")).to eq({method: "command", arguments: ["number", "color"]})
      expect(ParkingLotMain.new.extract_command_from_line("command")).to eq({method: "command", arguments: []})
    end
  end

  describe 'setup_lot_and_slots' do
    it 'to create lot and slots' do
      expect(ParkingLotMain.new.setup_lot_and_slots({method: "create_parking_lot", arguments: ['6']})).to be_kind_of(Array)
    end
  end

end
