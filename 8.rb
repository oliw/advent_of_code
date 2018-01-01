
f = File.open('8-input.txt', "r")

registers = Hash.new(0)

f.read.split("\n").each do |line|
	instruction = line.split(' ')
	register = instruction[0]
	command = instruction[1]
	amount = instruction[2].to_i
	conditional_register = instruction[4]
	conditional_expression = instruction[5]
	conditional_value = instruction[6]

	register_value = registers[register]
	if command == 'inc'
		register_value += amount
	elsif command == 'dec'
		register_value -= amount
	end
	
	if eval("#{registers[conditional_register]} #{conditional_expression} #{conditional_value}")
		registers[register] = register_value
	end
end

puts registers.values.max
