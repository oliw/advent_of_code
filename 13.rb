class Layer
  def initialize(range)
    @range = range
    @current_position = 0
    @moving_downwards = true
  end

  def scanner_at_top?
    @current_position == 0
  end

  attr_reader :range

  def tick
    if @moving_downwards
      @current_position += 1
    else
      @current_position -= 1
    end
    if @current_position == 0 || @current_position == @range - 1
      @moving_downwards = !@moving_downwards
    end
  end
end

firewall = Hash.new

File.open('13-input.txt').readlines.each do |line|
  parts = line.chomp.split(': ')
  depth = parts[0].to_i
  range = parts[1].to_i
  firewall[depth] = Layer.new(range)
end

max_picoseconds = firewall.keys.max


picoseconds_elapsed = 0
current_layer = -1
severity = 0
while current_layer <= max_picoseconds
  current_layer += 1
  layer = firewall[current_layer]
  unless layer.nil?
    if layer.scanner_at_top?
      severity += layer.range * current_layer
    end
  end
  firewall.values.each(&:tick)
end

puts severity