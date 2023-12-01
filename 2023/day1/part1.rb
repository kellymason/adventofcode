TEST_INPUT = [
  "1abc2",
  "pqr3stu8vwx",
  "a1b2c3d4e5f",
  "treb7uchet"
]

def get_input
  steps = IO.readlines("input.txt")
  # steps = TEST_INPUT
end

# Consider your entire calibration document. What is the sum of all of the calibration values?
# for each line, find the first integer and the last integer
# smush them together, add to the running total
# return the running total

# ways to check if a digit in a string is an integer:
# digit.to_i > 0
# regex

def solve_part_1
  strings_containing_calibration_values = get_input
  sum_of_calibration_values = 0
  strings_containing_calibration_values.each do |str|
    digits_in_string = str.scan(/\d/)
    calibration_value = (digits_in_string[0] + digits_in_string[-1]).to_i
    sum_of_calibration_values += calibration_value
  end
  puts sum_of_calibration_values
end

solve_part_1