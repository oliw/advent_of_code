def horizontal_flip(input_array)
  input_array.reverse
end

def verticle_flip(input_array)
  input_array.transpose.reverse.transpose
end

def rotate(input_array, degrees)
  (degrees / 90).times do
    input_array = input_array.reverse.transpose
  end
  input_array
end

def matches(input_array, rule_array)
  return true if input_array == rule_array
  return true if horizontal_flip(input_array) == rule_array
  return true if verticle_flip(input_array) == rule_array
  return true if rotate(input_array, 90) == rule_array
  return true if rotate(input_array, 180) == rule_array
  return true if rotate(input_array, 270) == rule_array
  false
end

def to_2d_array(input)
  input.split('/').map {|row| row.split('')}
end

def sub_array(xs, rows, columns)
  xs[rows].map { |row| row[columns] }
end

def convert_square(input_square, rules)
  rules.keys.each do |key|
    return rules[key] if matches(input_square, key)
  end
  puts "Warning no match found!"
  binding.pry()
  nil
end

def fill(large_array, small_array, x, y)
  curr_x = 0
  while curr_x < small_array.length do
    curr_y = 0
    while curr_y < small_array.length do
      large_array[curr_x+x][curr_y+y] = small_array[curr_x][curr_y]
      curr_y += 1
    end
    curr_x += 1
  end
  large_array
end

rules = Hash.new
File.open('21-input.txt').readlines.each do |line|
  parts = line.chomp.split(' => ')
  key = to_2d_array(parts[0])
  value = to_2d_array(parts[1])
  [0,90,180,270].each do |degrees|
      # LEARNING these are all the possible permutations
      rotated = rotate(key, degrees)
      flipped_lr = verticle_flip(rotated)
      flipped_ud = horizontal_flip(rotated) 
      rules[rotated] = value
      rules[flipped_lr] = value
      rules[flipped_ud] = value
  end
end

image = to_2d_array('.#./..#/###')
5.times do
  size = image.length
  if size % 2 == 0
    divisor = 2
  else
    divisor = 3
  end
  new_divisor_size = divisor + 1
  square_size = size / divisor # the number of subsquares
  new_image_size = square_size * new_divisor_size
  new_image = []
  new_image_size.times do
    new_row = []
    new_image_size.times do
      new_row << nil
    end
    new_image << new_row
  end
  new_image_x_offset = 0
  square_x_offset = 0
  while square_x_offset < size
    square_y_offset = 0
    new_image_y_offset = 0
    while square_y_offset < size
      square = sub_array(image, square_x_offset...(square_x_offset+divisor), square_y_offset...(square_y_offset+divisor))
      new_square = convert_square(square, rules)
      pp new_square
      new_image = fill(new_image, new_square, new_image_x_offset, new_image_y_offset)
      new_image_y_offset += new_divisor_size
      square_y_offset += divisor
    end
    new_image_x_offset += new_divisor_size
    square_x_offset += divisor
  end
  image = new_image
end

# count
count = 0
image.each do |row|
  row.each do |elem|
    count += 1 if elem == '#'
  end
end
puts count