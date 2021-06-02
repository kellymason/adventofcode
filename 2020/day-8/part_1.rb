# Program returns to input[486] from input[629]
CORRECT_ANSWER = 2003

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

# loops through instructions until an instruction is visited twice,
# following 'jmp', 'acc', and 'nop' instructions accordingly
# prints out the final acc value.
def acc_value_after_one_loop
  input = get_formatted_input
  acc_value = 0
  list_position = 0
  visited_positions = []
  while !visited_positions.include?(list_position) do
    visited_positions.push(list_position)
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
  # use the list of visited positions
  # to determine which position is corrupted in part 2
  puts visited_positions
  puts list_position
  puts acc_value
end

acc_value_after_one_loop
