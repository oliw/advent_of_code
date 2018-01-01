
f = File.open('7-input.txt', "r")

process_names = []
process_names_with_children = []

f.read.split("\n").each do |line|
	line_parts = line.split(" -> ")
	next if line_parts.length == 1

	name_and_weight = line_parts[0].split(" ")
	process_name = name_and_weight[0]
	process_names.push(process_name)
	process_children = line_parts[1].split(", ")
	process_names_with_children += process_children
end

process_names_without_children = process_names - process_names_with_children
puts process_names_without_children