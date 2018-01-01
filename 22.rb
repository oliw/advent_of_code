initial = []
infinite_grid = Hash.new('.')
File.open('22-input.txt').readlines.each_with_index do |line, row_idx|
  row = line.chomp.split('')
  row.each_with_index do |elem, col_idx|
    infinite_grid[[col_idx, row_idx]] = elem
  end
  initial << row
end

middle_x = (initial.length / 2)
middle_y = (initial[0].length / 2)

bursts_with_infections = 0


DIRECTIONS = ['north', 'east', 'south', 'west']

def next_direction(current_direction, current_node)
  if current_node == '#'
    # turn right
    dirs = DIRECTIONS
    dirs[(DIRECTIONS.index(current_direction) + 1) % DIRECTIONS.length]
  else
    # turn left
    dirs = DIRECTIONS.reverse
    dirs[(DIRECTIONS.reverse.index(current_direction) + 1) % DIRECTIONS.length]
  end
end

current_x = middle_x
current_y = middle_y
current_direction = 'north'
10_000.times do
  infection_caused = false
  current_node = infinite_grid[[current_x, current_y]]
  current_direction = next_direction(current_direction, current_node)
  if current_node == '#'
    infinite_grid[[current_x, current_y]] = '.'
  else
    infection_caused = true
    infinite_grid[[current_x, current_y]] = '#'
  end
  case current_direction
  when 'north'
    current_y -= 1
  when 'east'
    current_x += 1
  when 'south'
    current_y += 1
  else
    current_x -= 1
  end
  bursts_with_infections += 1 if infection_caused
end

puts bursts_with_infections
