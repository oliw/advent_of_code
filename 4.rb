num_valid = 0

f = File.open('4-input.txt', "r")
f.each_line do |line|
	words = line.split(" ")
	num_valid += 1 if words.uniq.length == words.length
end

puts num_valid
