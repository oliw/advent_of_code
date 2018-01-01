checksum = 0

f = File.open('2-input.txt', "r")
f.each_line do |line|
	numbers = line.split("\t").map(&:to_i)
	checksum += numbers.max - numbers.min
end

puts checksum
