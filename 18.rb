require 'pp'
require 'pry'

instructions = []
f = File.open('18-input.txt').readlines.each do |line|
  instructions << line.chomp
end

REGISTERS = Hash.new(0)

def operand_value(value)
  if value >= 'a' && value <= 'z'
    REGISTERS[value]
  else
    value.to_i
  end
end

current_instruction = 0
last_frequency = nil
while true do
  instruction = instructions[current_instruction]
  instruction_parts = instruction.split(' ')
  case instruction_parts[0]
  when 'snd'
    last_frequency = operand_value(instruction_parts[1])
    current_instruction += 1
  when 'set'
    REGISTERS[instruction_parts[1]] = operand_value(instruction_parts[2])
    current_instruction += 1
  when 'add'
    REGISTERS[instruction_parts[1]] += operand_value(instruction_parts[2])
    current_instruction += 1    
  when 'mul'
    REGISTERS[instruction_parts[1]] *= operand_value(instruction_parts[2])
    current_instruction += 1    
  when 'mod'
    REGISTERS[instruction_parts[1]] %= operand_value(instruction_parts[2])
    current_instruction += 1  
  when 'rcv'
    if operand_value(instruction_parts[1]) > 0
      puts last_frequency
      break
    end
    current_instruction += 1
  when 'jgz'
    if operand_value(instruction_parts[1]) > 0
      current_instruction += operand_value(instruction_parts[2])
    else
      current_instruction += 1
    end
  end
end 