TEST_INPUT = ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]
def get_input
  steps = IO.readlines("input.txt")
  # steps = TEST_INPUT
end

# returns a tuple of [position, depth]
def position_and_depth_1(input)
  position, down, up = 0,0,0
  input.each do |instruction|
    dir, val = instruction.split(" ")
    if dir == "forward"
      position += val.to_i
    elsif dir == "down"
      down += val.to_i
    elsif dir == "up"
      up += val.to_i
    end
  end
  depth = down - up
  return [position, depth]
end

def position_and_depth_2(input)
  position, aim, depth = 0,0,0
  input.each do |instruction|
    dir, val = instruction.split(" ")
    if dir == "forward"
      position += val.to_i
      depth += aim * val.to_i
    elsif dir == "down"
      aim += val.to_i
    elsif dir == "up"
      aim -= val.to_i
    end
  end

  return [position, depth]
end

def solve_part_1
  position, depth = position_and_depth_1(get_input)
  return position * depth
end

def solve_part_2
  position, depth = position_and_depth_2(get_input)
  puts position, depth
  return position * depth
end

# puts solve_part_1
puts solve_part_2