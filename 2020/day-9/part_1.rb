CORRECT_ANSWER = 22406676
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

# keep an array of the previous 25 lines
# for each value after i = 24, find 2 values from array that sum to equal i
# remove those 2 values from array, remove i-25 from the array, add i to array
# return the first value that doesn't have a sum
def find_pattern_breaking_line(preamble_length)
  input = get_input
  test_values = input[preamble_length...input.length]
  previous_values = input[0...preamble_length]
  test_values.each do |val|
    has_sum = false
    (0).upto(previous_values.length - 1) do |i|
      break has_sum if has_sum
      (previous_values.length - 1).downto(1) do |j|
        if previous_values[i]+previous_values[j] == val
          has_sum = true
          previous_values.shift
          previous_values.push(val)
          break has_sum
        end
      end
    end
    return val if has_sum == false
  end
end

puts find_pattern_breaking_line(25)
