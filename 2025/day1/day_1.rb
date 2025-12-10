TEST_INPUT = [
  "L68",
  "L30",
  "R48",
  "L5",
  "R60",
  "L55",
  "L1",
  "L99",
  "R14",
  "L82",
]

# Read test input
# Save as an array of instruction strings
def get_input
  ARGV[1] ? TEST_INPUT : File.readlines("input.txt", chomp: true)
end

# Take in a string containing "L" or "R" and a number
# if the first char is "L", return the negated number 
# if the first char is "R", return the number 
def follow_instruction(initial_position, instruction)
  raw_change = instruction.slice!(1,50).to_i
  if instruction[0] == "L"
    # puts "subtracting #{raw_change}"
    initial_position - raw_change
  else
    # puts "adding #{raw_change}"
    initial_position + raw_change
  end
end

# Part 1 logic
def count_zero_positions(instructions)
    zero_counter = 0 # increment each time the dial reads 0 after a turn
    current_position = 50 # starts at 50. Can be 0-99, inclusive
    instructions.each do |instruction|
    # puts "instruction: #{instruction[0]}, #{instruction.slice!(1,50).to_i}"
    instruction += follow_instruction(instruction)
    while current_position > 99
      current_position -= 100
    end
    while current_position < 0
      current_position += 100
    end
    # puts "current_position: #{current_position}"
    zero_counter +=1 if current_position == 0
  end
  zero_counter
end

def passed_or_landed_on_zero?(current_position, new_position)
  current_position != 0 && (new_position <= 0 || new_position >= 100)
end

# Part 2 logic
def count_zero_passes(instructions)
  zero_counter = 0 # increment each time we pass zero or wrap
  current_position = 50 # starts at 50. Can be 0-99, inclusive
  instructions.each do |instruction|
    change_magnitude = instruction[1..].to_i
    # full_rotations = change_magnitude / 100
    # change_magnitude = change_magnitude % 100
    full_rotations, change_magnitude = change_magnitude.divmod(100)
    new_position = instruction[0] == "L" ? current_position - change_magnitude : current_position + change_magnitude
    zero_counter += 1 if passed_or_landed_on_zero?(current_position, new_position)
    zero_counter += full_rotations
    current_position = new_position % 100
  end
  zero_counter
end


def solve(part)
  instructions = get_input
  zero_counter = part == 1 ? count_zero_positions(instructions) : count_zero_passes(instructions)
  puts "zeros: #{zero_counter}"
end

solve(ARGV[0])