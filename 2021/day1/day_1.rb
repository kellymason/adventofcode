TEST_INPUT = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
def get_input
  steps = IO.readlines("2021/day1/input.txt").map(&:to_i)
  # steps = TEST_INPUT
end

# Answer: 1602
def count_depth_increases
  increase_counter = 0
  depth_measurements_array = get_input
  depth_measurements_array.each_with_index do |depth, ind|
    next if ind == 0
    increase_counter += 1 if depth > depth_measurements_array[ind - 1]
  end
  puts increase_counter
end

# Answer: 
def count_window_increases
  increase_counter = 0
  depth_measurements_array = get_input

  depth_measurements_array.each_with_index do |depth, ind|
    next if ind == 0
    if (depth_measurements_array[ind - 1] + depth + depth_measurements_array[ind + 1]) < (depth + depth_measurements_array[ind + 1] + depth_measurements_array[ind + 2])
      increase_counter += 1
    end
    return increase_counter if ind == depth_measurements_array.length - 3
  end
end

puts count_depth_increases
puts count_window_increases