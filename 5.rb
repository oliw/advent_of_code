
f = File.open('5-input.txt', "r")
instructions = f.read.split("\n").map(&:to_i)

steps = 0
curr_idx = 0

while curr_idx < instructions.length
	instruction = instructions[curr_idx]
	new_idx = curr_idx + instruction
	instructions[curr_idx] += 1
	curr_idx = new_idx
	steps += 1
end

puts steps
