TEST_INPUT = "11-22,95-115,998-1012,1188511880-1188511890;,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

# Return input as an array of tuples representing the ranges
# Ex. [[1,2], [95, 115], ...]
def get_input
  raw_input =  ARGV[1] == "test" ? TEST_INPUT : File.readlines("input.txt", chomp: true)[0]
  raw_input.split(",").map{|range| range.split("-").map(&:to_i)}
end

# Return the sum of all invalid IDs
# Take in a string
# Parse into [Num1, Num2] by splitting on commas and then mapping integers before and after hyphens
# A value in the range is invalid if it consists of EXACTLY two of the same number. Ex 123123 but not 12123
# Add up all invalid values
def part_1(input)
  invalid_sum = 0
  # Loop through each range
  # check each item in the range, incrementing the counter as needed
  input.each do |range| # a range has syntax like [11,22]
    # puts "range: #{range}"
    for value_to_check in range[0]..range[1]
      stringified_value_to_check = value_to_check.to_s
      string_length = stringified_value_to_check.length
      next if string_length % 2 > 0 # rule out odd lengths
      # check if the first half of the string is equal to the second half
      first_half = stringified_value_to_check[0..(string_length/2 - 1)]
      second_half = stringified_value_to_check[(string_length/2)..-1]
      if first_half == second_half
        invalid_sum += value_to_check 
      end
    end
  end
  puts invalid_sum
end

# Return true if the number consists exclusively of a sequence of characters 
#   repeated two or more times
def check_for_multiple_repeaters(number_string)
  pattern = /^(.+)\1+$/
  pattern.match?(number_string)
end

# Return the sum of all invalid ids
# A value in the range is invalid if it consists exclusively of more than one of the same number combination
# Ex 123123123
# One idea: we could check if the first number occurs more than once
#          if so, check the next number and check that it's the same next number
#          if there's something like 191191 how do we account for that?
#. is there an easy way to get all factors of an int?
def part_2(input)
  invalid_sum = 0
   input.each do |range|
    for value_to_check in range[0]..range[1]
      if check_for_multiple_repeaters(value_to_check.to_s)
        invalid_sum += value_to_check 
      end
    end
   end
   puts invalid_sum
end

# Add up all invalid IDs, return sum.
def solve(part)
  input = get_input
  if part == "1"
    part_1(input)
  elsif part == "2"
    part_2(input)
  else
    puts "OOPS! you put #{ARGV[0]}, expecting 1 or 2"
  end
end

solve(ARGV[0])