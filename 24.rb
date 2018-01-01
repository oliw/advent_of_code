class Node
  def initialize(top_port, bottom_port, value)
    @top_port = top_port
    @bottom_port = bottom_port
    @value = value
    @children = []
  end

  attr_reader :top_port
  attr_reader :bottom_port
  attr_reader :value
  attr_reader :children

  def add_child(node)
    @children << node
  end
end

class Component
  def initialize(ports)
    @ports = ports
  end

  attr_reader :ports

  def other_port(port)
    @ports[(@ports.index(port) + 1) % 2]
  end

  def to_s
    "Component #{ports[0]}/#{ports[1]}"
  end
end

# build inventory
inventory = []
File.open('24-input.txt').readlines.each do |line|
  component_input = line.chomp
  ports = component_input.split('/').map(&:to_i)
  component = Component.new(ports)
  inventory << component
end

# recursively build tree
previous_value = 0
top_port = 0
bottom_port = 0
longest = 0
VALUES = []
def build_tree(parent_value, parent_connecting_port, child_connecting_port, inventory)
  value = parent_value + parent_connecting_port + child_connecting_port
  tree = Node.new(parent_connecting_port,child_connecting_port,value)
  valid_components = inventory.select do |component|
    component.ports.include? child_connecting_port
  end
  VALUES << value
  valid_components.each do |component|
    new_inventory = inventory.clone
    component_index = new_inventory.index(component)
    new_inventory.delete_at(component_index)
    child = build_tree(value, child_connecting_port, component.other_port(child_connecting_port), new_inventory)
    tree.add_child(child)
  end
  return tree
end
tree = build_tree(0, 0, 0, inventory)

puts VALUES.max
