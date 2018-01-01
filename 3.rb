input = 361527

first = 1
last = input
curr = first

layer_x = 0
layer_y = 0
i_x = 0
d_x = 0
i_y = 0
d_y = 0
direction_y = 1
direction_x = 1 # 1 = to the right, -1 to the left
travelling_horizontal = true

while curr < last do
  if travelling_horizontal
    if i_x <= layer_x
      i_x += 1
      d_x += direction_x
      curr += 1
    else
      direction_x *= -1
      travelling_horizontal = false
      i_x = 0
      layer_x += 1
    end
  else
    # moving vertical
    if i_y <= layer_y
      i_y += 1
      d_y += direction_y
      curr += 1
    else
      direction_y *= -1
      travelling_horizontal = true
      i_y = 0
      layer_y += 1
    end
  end
end

manhattan_distance = d_x.abs + d_y.abs
puts manhattan_distance