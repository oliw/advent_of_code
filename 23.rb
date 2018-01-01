require 'pp'
require 'pry'

instructions = []
f = File.open('23-input.txt').readlines.each do |line|
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

def part_one
  current_instruction = 0
  mul_count = 0
  while true do
    instruction = instructions[current_instruction]
    break if instruction.nil?
    instruction_parts = instruction.split(' ')
    case instruction_parts[0]
    when 'set'
      REGISTERS[instruction_parts[1]] = operand_value(instruction_parts[2])
      current_instruction += 1
    when 'sub'
      REGISTERS[instruction_parts[1]] -= operand_value(instruction_parts[2])
      current_instruction += 1    
    when 'mul'
      REGISTERS[instruction_parts[1]] *= operand_value(instruction_parts[2])
      mul_count += 1
      current_instruction += 1    
    when 'jnz'
      if operand_value(instruction_parts[1]) != 0
        current_instruction += operand_value(instruction_parts[2])
      else
        current_instruction += 1
      end
    end
  end 

  puts mul_count
end

require 'prime'

def part_two
  b = 106700
  c = 123700
  h = 0
  while (b <= c) do
    h +=1 unless Prime.prime?(b)
    b += 17
  end
  puts h
end

part_two