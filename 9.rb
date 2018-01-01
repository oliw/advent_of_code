def count(input)
  # stack!
  stack = []
  i = 0
  overall_score = 0
  while i < input.length do
    curr = input[i]
    if curr == '{'
      stack.push(curr)
    end
    if curr == '}'
      score = stack.length
      stack.pop()
      overall_score += score
    end 
    i+=1
  end
  overall_score
end

def scrub(input)
  clean = ''
  i = 0
  skip = false
  garbage_mode = false
  group_start = nil
  while i < input.length do
    if skip
      skip = false
      i += 1
      next
    end
    curr = input[i]
    if curr == '!'
      skip = true
      i += 1
      next
    end
    if garbage_mode
      if curr == '>'
        garbage_mode = false
      end
      i += 1
      next
    end
    if curr == '<'
      garbage_mode = true
      i += 1
      next
    end
    clean += curr
    i += 1
    next
  end
  clean
end

f = File.open('9-input.txt', "r")
input = f.read
clean_input = scrub(input)
puts count(clean_input)