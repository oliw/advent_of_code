tape = Hash.new(0)
current_index = 0
current_state = "A"

12425180.times do
  current_value = tape[current_index]
  case current_state
  when 'A'
    if current_value == 0
      tape[current_index] = 1
      current_index += 1
      current_state = 'B'
    else
      tape[current_index] = 0
      current_index += 1
      current_state = 'F'
    end
  when 'B'
    if current_value == 0
      tape[current_index] = 0
      current_index -= 1
      current_state = 'B'
    else
      tape[current_index] = 1
      current_index -= 1
      current_state = 'C'
    end
  when 'C'
    if current_value == 0
      tape[current_index] = 1
      current_index -= 1
      current_state = 'D'
    else
      tape[current_index] = 0
      current_index += 1
      current_state = 'C'
    end
  when 'D'
    if current_value == 0
      tape[current_index] = 1
      current_index -= 1
      current_state = 'E'
    else
      tape[current_index] = 1
      current_index += 1
      current_state = 'A'
    end
  when 'E'
    if current_value == 0
      tape[current_index] = 1
      current_index -= 1
      current_state = 'F'
    else
      tape[current_index] = 0
      current_index -= 1
      current_state = 'D'
    end
  when 'F'
    if current_value == 0
      tape[current_index] = 1
      current_index += 1
      current_state = 'A'
    else
      tape[current_index] = 0
      current_index -= 1
      current_state = 'E'
    end
  end
end

puts tape.values.inject(0, :+)