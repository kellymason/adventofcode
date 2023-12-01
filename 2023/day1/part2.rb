TEST_INPUT = [
  "two1nine"
  "eightwothree"
  "abcone2threexyz"
  "xtwone3four"
  "4nineeightseven2"
  "zoneight234"
  "7pqrstsixteen"
]

SPELLED_OUT_DIGIT_STRINGS = [
  "zero"
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine"
]

def get_input
  # steps = IO.readlines("input.txt")
  steps = TEST_INPUT
end


def solve_part_2
  strings_containing_calibration_values = get_input
  sum_of_calibration_values = 0
  strings_containing_calibration_values.each do |str|
    # change the regex to capture ints and SPELLED_OUT_DIGIT_STRINGS
    digits_in_string = str.scan(/\d/)
    # convert any spelled out digits to ints, can use SPELLED_OUT_DIGIT_STRINGS[i]
    calibration_value = (digits_in_string[0] + digits_in_string[-1]).to_i
    sum_of_calibration_values += calibration_value
  end
  puts sum_of_calibration_values
end

solve_part_2