require 'pp'

# parse diagram
diagram = []
File.open('19-input.txt').readlines.each do |row|
  diagram << row.split('')
end

# move to start
row = 0
col = 0
while (diagram[row][col] == ' ') do
  col += 1
end

# start moving
direction = 'south'

letters = ''

def next_row(current_row, current_col, current_direction, diagram)
  next_direct = next_direction(current_row, current_col, current_direction, diagram)
  if next_direct == 'north'
    current_row - 1
  elsif next_direct == 'south'
    current_row + 1
  else
    current_row
  end     
end

def next_col(current_row, current_col, current_direction, diagram)
  next_direct = next_direction(current_row, current_col, current_direction, diagram)
  if next_direct == 'east'
    current_col + 1
  elsif next_direct == 'west'
    current_col - 1
  else
    current_col
  end 
end

def is_valid?(row, col, diagram)
  diagram.length >= 0 && diagram.length > row && diagram[0].length >= 0 && diagram[0].length > col
end


def next_direction(current_row, current_col, current_direction, diagram)
  if diagram[current_row][current_col] == '+'
    if %w(north south).include? current_direction
      # look east or west for a -
      if is_valid?(current_row, current_col-1, diagram) && diagram[current_row][current_col-1] != ' '
        # looked west and found one!
        return 'west'
      elsif is_valid?(current_row, current_col+1, diagram) && diagram[current_row][current_col+1] != ' '
        return 'east'
      end
    else
      # look north of south for a |
      if is_valid?(current_row-1, current_col, diagram) && diagram[current_row-1][current_col] != ' '
        # looked north and found one!
        return 'north'
      elsif is_valid?(current_row+1, current_col, diagram) && diagram[current_row+1][current_col] != ' '
        return 'south'
      end
    end
  else
    current_direction
  end
end

while (diagram[row][col] != ' ') do
  if diagram[row][col] >= 'A' && diagram[row][col] <= 'Z'
    # found a letter
    letters += diagram[row][col]
  end
  old_row = row
  old_col = col
  row = next_row(old_row, old_col, direction, diagram)
  col = next_col(old_row, old_col, direction, diagram)
  direction = next_direction(old_row, old_col, direction, diagram)
end

pp letters

