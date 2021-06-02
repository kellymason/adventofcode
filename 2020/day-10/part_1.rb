CORRECT_ANSWER = 2450
TEST_INPUT = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]

def get_input
  IO.readlines("input.txt").map{|l| l.to_i}.sort!
end

# takes in input as an array of ints
# outputs a 2-element array with the count of 1-jolt diffs and
#   the count of 3-jolt diffs (including the 3-jolt difference from the highest adapter to the built-in adapter)
def get_jolt_differences(input)
  one_jolt_count = 0
  three_jolt_count = 0
  input.each_with_index do |x, i|
    if i == 0
      if x == 1
        one_jolt_count += 1
      elsif x == 3
        three_jolt_count += 1
      end
    else
      if input[i] - input[i-1] == 1
        one_jolt_count += 1
      elsif input[i] - input[i-1] == 3
        three_jolt_count += 1
      end
    end
  end
  # account for the last 3-jolt jump
  three_jolt_count += 1
  return [one_jolt_count, three_jolt_count]
end

def get_final_answer
  input = get_input.sort
  one_jolt_count, three_jolt_count = get_jolt_differences(input)
  puts one_jolt_count * three_jolt_count
end

get_final_answer
