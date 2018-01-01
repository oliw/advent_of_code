f = File.open('12-input.txt')

links = Hash.new

f.readlines.each do |line|
  parts = line.chomp.split(" <-> ")
  key = parts[0].to_i
  values = parts[1].split(", ").map(&:to_i)
  links[key] = values
end

visited = Hash.new(false)

enqueued = [0]

while(enqueued.length > 0) do
  current = enqueued.pop
  visited[current] = true
  neighbors = links[current]
  neighbors.each do |neighbor|
    next if visited[neighbor]
    enqueued.push(neighbor)
  end
end

puts visited.keys.count
