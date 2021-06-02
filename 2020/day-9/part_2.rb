PART_ONE_ANSWER = 22406676
TEST_PART_ONE_ANSWER = 127 
TEST_INPUT = [
  35,
  20,
  15,
  25,
  47,
  40,
  62,
  55,
  65,
  95,
  102,
  117,
  150,
  182,
  127,
  219,
  299,
  277,
  309,
  576,
]
# parse input, output it as an array of integers
def get_input
  IO.readlines("input.txt").map{|l| l.to_i}
end

# go through input list
# for each val, add the next value(s) until the value <= PART_ONE_ANSWER 
def find_contiguous_range(input)
  desired_sum = PART_ONE_ANSWER
  input.each_with_index do |line, index|
    current_range_sum = line
    current_range = [line]
    while current_range_sum < desired_sum && index + current_range.length < input.length
      current_range_sum += input[index + current_range.length]
      current_range.push(input[index + current_range.length])
      if current_range_sum == desired_sum
        return [current_range.min, current_range.max]
      end
    end
  end
end

def find_min_max_sum(lower_value, upper_value)
  lower_value + upper_value
end

def get_encryption_weakness
  input = get_input
  min_and_max_values = find_contiguous_range(input)
  puts find_min_max_sum(min_and_max_values[0], min_and_max_values[1])
end

get_encryption_weakness
