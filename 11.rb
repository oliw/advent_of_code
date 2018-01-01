input = File.open('11-input.txt').read
steps = input.split(',').map(&:chomp)
east_score = 0
north_score = 0
steps.each do |step|
  if step.length == 1
    north_score += 1 if step == 'n'
    north_score += -1 if step == 's'
  end
  if step.length == 2
    north_score += 0.5 if step[0] == 'n'
    north_score += -0.5 if step[0] == 's'
    east_score += 0.5 if step[1] == 'e'
    east_score += -0.5 if step[1] == 'w'
  end
end

count = 0
while east_score != 0 do
  if east_score > 0
    east_score -= 0.5
  else
    east_score += 0.5
  end
  if north_score > 0
    north_score -= 0.5
  else
    north_score += 0.5
  end
  count += 1
end

while north_score != 0 do
  if north_score > 0
    north_score -= 1
  else
    north_score += 1
  end
  count += 1
end

puts count
