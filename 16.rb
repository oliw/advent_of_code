f = File.open('16-input.txt').read
positions = ('a'..'p').to_a
moves = f.split(',')

def spin(pos)
  pos[0..-2].unshift(pos[-1])
end

moves.each do |move|
  if move[0] == 's'
    # spin
    amount = move[1..-1].to_i
    amount.times do
      positions = spin(positions)
    end
  elsif move[0] == 'x'
    # exchange
    pos = move[1..-1].split('/').map(&:to_i)
    tmp = positions[pos[0]]
    positions[pos[0]] = positions[pos[1]]
    positions[pos[1]] = tmp
  else
    # partner
    pos = move[1..-1].split('/')
    idx_a = positions.find_index(pos[0])
    idx_b = positions.find_index(pos[1])
    tmp = positions[idx_a]
    positions[idx_a] = positions[idx_b]
    positions[idx_b] = tmp
  end
end

puts positions.join('')