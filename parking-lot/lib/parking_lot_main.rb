require 'io/console'
require 'pry'
load 'lib/parking_lot.rb'
load 'lib/slot.rb'

AVAILABLE_COMMANDS = ["create_parking_lot", "park", "leave", "status", "registration_numbers_for_cars_with_colour", "slot_numbers_for_cars_with_colour", "slot_number_for_registration_number"]

class ParkingLotMain

	def initialize
		@@lot = nil
		@@cars = []
		@@slots = []
	end

	def open_parking_lot
		indentify_commands
	end
	
	#Function to initiate parking lot
	def indentify_commands
		if is_file_input?(ARGV)
			commands = extract_commands_from_input_file(ARGV)
			initiate_parking(commands.shift)
			run_commands_from_file(commands) if @@lot
		else
			read_command_from_console_and_extract
		end
	end

	#Function to read command from console and extract
	def read_command_from_console_and_extract
		puts "\n<<< PARKING LOT >>>\n"
		while true
			input = gets
			break if input == "close_parking_lot\n"
			command = extract_command_from_line(input)
			if @@lot
				run_command(command)
			else
				initiate_parking(command)
			end
		end
	end

	#Function to check if the input if file or not
	def is_file_input?(command_line_arguments)
		command_line_arguments.any?
	end

	#Function to extract commands from file
	def extract_commands_from_input_file(args)
		commands = []
		File.open(args[0], "r").each do | line |
			commands << extract_command_from_line(line)
		end
		commands
	end

	#Function to extract commands from a string
	def extract_command_from_line(line)
		values = line.split(" ")
		if values.length > 1
			{method: values[0], arguments: values[1..values.length-1]}
		else
			{method: values[0], arguments: []}
		end
	end

	#Function to initiate parking 
	def initiate_parking(command)
		if is_a_create_command?(command[:method])
			setup_lot_and_slots(command)
		else
			puts "You should create a parking lot first"
		end
	end

	#Function to run commands from file
	def run_commands_from_file(commands)
		commands.each do |command|
			run_command(command)
		end

	end

	#Function to create lot and slots
	def setup_lot_and_slots(command)
		@@lot = ParkingLot.create_parking_lot(command[:arguments])
		@@slots = Slot.create_slots(@@lot) if @@lot
	end

	#Function to run command
	def run_command(command)
		if is_command_valid?(command[:method])
			if is_there_a_lot? && is_a_create_command?(command[:method])
				puts "A Parking lot already exists, You can close parking lot by 'close_parking_lot'"
			else
				result = @@lot.public_send command[:method], @@slots, @@cars, command[:arguments]
				puts "\n" + result.to_s if result
			end
		else
			puts "Invalid Command, Command: #{command[:method]}"
		end
	end

	private

	#Function check whether a given command is valid or not
	def is_command_valid?(command)
		AVAILABLE_COMMANDS.include?(command)
	end

	#Function to check if a lot already exists or not
	def is_there_a_lot?
		@@lot
	end

	#Function to check if a command is create_parking_lot or not
	def is_a_create_command?(command)
		command == "create_parking_lot" ? true : false
	end

	ParkingLotMain.new.open_parking_lot
end

