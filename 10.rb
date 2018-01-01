def part_one
  f = File.open('10-input.txt', "r")
  input_lengths = f.read.split(',').map(&:to_i)
  number_list = (0..255).to_a
  current_position = 0
  skip_size = 0

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

  puts number_list[0] * number_list[1]
end

def part_two(input)
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

  puts final
end

part_two("97,167,54,178,2,11,209,174,119,248,254,0,255,1,64,190")