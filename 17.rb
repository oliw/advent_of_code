input = 371

buffer = [0]
current_position = 0
number_to_insert = 1

2017.times do
  current_position = (current_position + input) % buffer.length + 1
  buffer.insert(current_position, number_to_insert)
  number_to_insert += 1
end

puts buffer[(buffer.index(2017)+1) % buffer.length]