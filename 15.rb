a = 634
b = 301

def lowest_16_bits(number)
  binary = number.to_s(2)
  full_binary = binary
  (32-binary.length).times do
    full_binary = "0"+full_binary
  end
  full_binary[-16..-1].split('')
end

def match_exists?(first, second)
  lowest_16_bits(first) == lowest_16_bits(second)
end

matches = 0

40_000_000.times do |i|
  a *= 16807
  b *= 48271
  a = a % 2147483647
  b = b % 2147483647
  matches += 1 if match_exists?(a, b)
end

puts matches