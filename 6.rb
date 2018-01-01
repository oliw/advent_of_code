
f = File.open('6-input.txt', "r")
current_banks = f.read.split("\n")[0].split("\t").map(&:to_i)

seen_configs = []

redistributions = 0
while (!seen_configs.include?(current_banks))
	seen_configs.push(current_banks)
	
	# find largest bank
	largest_block_count = current_banks.max
	first_largest_block = current_banks.find_index(largest_block_count)

	blocks_to_disperse = largest_block_count
	new_banks = current_banks.dup
	new_banks[first_largest_block] = 0

	current_index = first_largest_block
	while blocks_to_disperse > 0 do
		current_index = (current_index + 1) % current_banks.length
		new_banks[current_index] += 1
		blocks_to_disperse -= 1
	end

	current_banks = new_banks
	redistributions += 1
end

puts redistributions


