# copied from 10.rb
def to_knot_hash(input)
  byte_input = input.split('').map(&:ord)
  input_lengths = byte_input+[17, 31, 73, 47, 23]
  number_list = (0..255).to_a
  current_position = 0
  skip_size = 0

  64.times do
    input_lengths.each do |length|
      ring_buffer = number_list + number_list
      start_idx = current_position
      end_idx = current_position + length
      sublist = ring_buffer[start_idx...end_idx]
      sublist = sublist.reverse
      ring_buffer[start_idx...end_idx] = sublist
      
      curr_idx = start_idx
      while (curr_idx < end_idx) do
        number_list[curr_idx % number_list.length] = ring_buffer[curr_idx]
        curr_idx += 1
      end 
      current_position = (current_position + length + skip_size) % number_list.length
      skip_size += 1
    end
  end

  dense_hash = number_list.each_slice(16).to_a.map do |numbers|
    numbers.reduce(:^)
  end

  final = dense_hash.map do |number|
    hex = number.to_s(16)
    hex = "0"+hex if hex.length == 1
    hex
  end.join('')

  final
end

input = "uugsqrei"

used = 0
(0...128).each do |i|
  knot_hash_input = input + "-#{i}"
  knot_hash_output = to_knot_hash(knot_hash_input)
  bits = knot_hash_output.to_i(16).to_s(2)
  used += bits.split('').map(&:to_i).inject(0, :+)
end

puts used