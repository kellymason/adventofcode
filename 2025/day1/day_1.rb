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
  ARGV[1] == "test" ? TEST_INPUT : File.readlines("input.txt", chomp: true)
end

# Part 1 helper - part 2 has an extra step that complicates things
def get_new_position(current_position, instruction)
  change_magnitude = instruction[1..].to_i
  instruction[0] == "L" ? current_position - change_magnitude : current_position + change_magnitude
end

# Part 1 logic
def count_zero_positions(instructions)
    zero_counter = 0 # increment each time the dial reads 0 after a turn
    current_position = 50 # starts at 50. Can be 0-99, inclusive
    instructions.each do |instruction|
    current_position = get_new_position(current_position, instruction)
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

# Part 2 helper
def passed_or_landed_on_zero?(current_position, new_position)
  current_position != 0 && (new_position <= 0 || new_position >= 100)
end

# Part 2 logic
def count_zero_passes(instructions)
  zero_counter = 0 # increment each time we pass zero or wrap
  current_position = 50 # starts at 50. Can be 0-99, inclusive
  instructions.each do |instruction|
    change_magnitude = instruction[1..].to_i
    full_rotations, change_magnitude = change_magnitude.divmod(100)
    new_position = instruction[0] == "L" ? current_position - change_magnitude : current_position + change_magnitude
    # Add to the counter for each time we passed or landed on zero, or each time the dial moved 100 places.
    zero_counter += 1 if passed_or_landed_on_zero?(current_position, new_position)
    zero_counter += full_rotations
    current_position = new_position % 100
  end
  zero_counter
end

def solve(part)
  instructions = get_input
  if part == "1"
    zero_counter = count_zero_positions(instructions)
  elsif part == "2"
    zero_counter = count_zero_passes(instructions)
  else
    puts "oops! Pass in 1 or 2 to indicate which part to solve"
  end
  puts "zeros: #{zero_counter}"
end

solve(ARGV[0])