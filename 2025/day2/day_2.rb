TEST_INPUT = "11-22,95-115,998-1012,1188511880-1188511890;,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

# Return input as an array of tuples representing the ranges
# Ex. [[1,2], [95, 115], ...]
def get_input
  raw_input = ARGV[0] ? TEST_INPUT : File.readlines("input.txt", chomp: true)[0]
  raw_input.split(",").map{|range| range.split("-").map(&:to_i)}
end

# Return the sum of all invalid IDs
# Take in a string
# Parse into [Num1, Num2] by splitting on commas and then mapping integers before and after hyphens
# A value in the range is invalid if it consists of EXACTLY two of the same number. Ex 123123 but not 12123
# Add up all invalid values
def part_1(input)
  invalid_sum = 0
  puts "input: #{input}"
  # Loop through each range
  # check each item in the range, incrementing the counter as needed
  input.each do |range| # a range has syntax like [11,22]
    # puts "range: #{range}"
    for value_to_check in range[0]..range[1]
      # puts "value_to_check: #{value_to_check}"
      stringified_value_to_check = value_to_check.to_s
      string_length = stringified_value_to_check.length
      next if string_length % 2 > 0 # rule out odd lengths
      # check if the first half of the string is equal to the second half
      first_half = stringified_value_to_check[0..(string_length/2 - 1)]
      second_half = stringified_value_to_check[(string_length/2)..-1]
      # puts "first half: #{first_half}, second_half: #{second_half}"
      if first_half == second_half
        # puts "first half: #{first_half}, second_half: #{second_half}"
        # puts "#{value_to_check} is invalid"
        invalid_sum += value_to_check 
      end
    end
  end
  puts invalid_sum
end

def part_2(input)
  # Placeholder for part 2 logic
end

# Add up all invalid IDs, return sum.
def solve
  input = get_input
  part_1(input)
end

solve