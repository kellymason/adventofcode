# This was a brute force solution:
# I changed input.txt at a given index from 'nop' to 'jmp' or vice versa
# until the program returned.
# I used the output of visited_positions (in reverse order) from part_1
# to indicate which line to change.

RIGHT_ANSWER = 1984
REVISITED_POSITION = 486

TEST_INPUT = [
  ["nop", 0],
  ["acc", 1],
  ["jmp", 4],
  ["acc", 3],
  ["jmp", -3],
  ["acc", -99],
  ["acc", 1],
  ["nop", -4],
  ["acc", 6],
]
# Reads lines from input.txt,
# formats each line (representing an instruction) to an array of:
#   [instruction, argument]
# returns an array of array-formatted instructions:
#   [
#     ['jmp', 248],
#     ['acc', -7]
#   ]
def get_formatted_input
  lines_list = IO.read('input.txt').split("\n")
  lines_list.map do |line|
    [line[0..2], line[4...line.length].to_i]
  end
end

def loop_through_instructions
  input = get_formatted_input
  list_position = 0
  acc_value = 0
  until list_position >= input.length do
    case input[list_position][0]
    when "jmp"
      list_position += input[list_position][1]
    when "acc"
      acc_value += input[list_position][1]
      list_position += 1
    when "nop"
      list_position += 1
    else
      puts "Oops, unexpected instruction: #{input[list_position]}"
    end
  end
  puts "list position: #{list_position}"
  puts "accumulator value: #{acc_value}"
end

loop_through_instructions
