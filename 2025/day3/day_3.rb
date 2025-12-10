TEST_INPUT = [
"987654321111111",
"811111111111119",
"234234234234278",
"818181911112111"
]

# Read test input
# Save as an array of instruction strings
def get_input
  ARGV[1] == "test" ? TEST_INPUT : File.readlines("input.txt", chomp: true)
end

# Find the highest int that occurs prior to the last number (this will represent the 10's place)
# Then find the highest int that occurs after the highest int
# Combine them, convert to an int, and add to the total
# Return the total
def part_1(input)
  total_joltage = 0
  input.each do |bank|
    highest_digit = bank.chars.max
    index_of_highest_digit = bank.index(highest_digit)
    if index_of_highest_digit == bank.length - 1 # our highest digit is the last one, so search before it
      next_highest_digit = bank.chars[0...-1].max
      largest_bank_joltage = (next_highest_digit + highest_digit).to_i
    else # default case, only look at ints appearing after the highest digit
      next_highest_digit = bank.chars[(index_of_highest_digit+1)..].max
      largest_bank_joltage = (highest_digit + next_highest_digit).to_i
    end
    total_joltage += largest_bank_joltage
  end
  puts total_joltage
end

  # Answer: 167302518850275
  # Recursive helper to build the bank_joltage string
  # The offset represents how many digits would have to come after the current max_digit
  # in order to end up with 12 digits
  def recursive_highest_digits(remaining_batteries, offset = 11, result = "")
    return result if result.length == 12 # if true, we have all the batteries we need
    range = remaining_batteries[0...-offset]
    if range.empty?
      max_digit = remaining_batteries.max
    else
      max_digit = range.max
    end
    result += max_digit
    max_digit_index = remaining_batteries.index(max_digit)
    # Next: search the digits occurring after the current max_digit, decrementing the offset
    recursive_highest_digits(remaining_batteries[(max_digit_index+1)..-1], offset - 1, result)
  end


# Iterate through the banks (lines of input)
#   For each bank, iterate through the batteries (chars)
#     Find the highest int that occurs before the final 11 elements. Append it to bank_joltage.
#     Then find the highest int that occurs between the highest int and the final 10 elements. Append it to bank_joltage.
#     Then find the highest int that occurs between the second highest int and the final 9 elements. Append it to bank_joltage.
#     Continue this pattern recursively
#   Add bank_joltage to total_joltage
# Return total_joltage
def part_2(input)
  total_joltage = 0
  input.each do |bank|
    battery_arr = bank.chars
    bank_joltage = recursive_highest_digits(battery_arr)
    total_joltage += bank_joltage.to_i unless bank_joltage.empty?
  end
  puts total_joltage
end

def solve(part)
  if part == "1"
    part_1(get_input)
  elsif part == "2"
    part_2(get_input)
  else
    puts "Oh no! First arg must be 1 or 2. You put #{ARGV[0]}"
  end

end

solve(ARGV[0])