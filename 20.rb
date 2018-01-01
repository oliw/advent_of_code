require 'matrix'

class Particle
  def initialize(idx, px,py,pz, vx,vy,vz,ax,ay,az)
    @idx = idx
    @position = Vector[px,py,pz]
    @velocity = Vector[vx,vy,vz]
    @acceleration = Vector[ax,ay,az]
  end

  def tick
    @velocity += @acceleration
    @position += @velocity
  end

  def distance
    @position.to_a.map(&:abs).inject(0){|sum,x| sum + x }
  end

  def distance_at_time_t(t)
    new_position = @position + t*@velocity + (0.5*t**2+0.5*t)*@acceleration
    new_position.to_a.map(&:abs).inject(0){|sum,x| sum + x }
  end

  attr_reader :idx
end

particles = []

File.open('20-input.txt').readlines.each_with_index do |line, idx|
  parts = line.chomp.split(", ")
  position = parts[0][3..-2].split(',').map(&:to_i)
  velocity = parts[1][3..-2].split(',').map(&:to_i)
  acc = parts[2][3..-2].split(',').map(&:to_i)
  particles << Particle.new(idx, position[0], position[1], position[2], velocity[0], velocity[1], velocity[2], acc[0], acc[1], acc[2])
end

particles = particles.sort_by do |particle|
  particle.distance_at_time_t(12_000_000)
end

puts "end"

