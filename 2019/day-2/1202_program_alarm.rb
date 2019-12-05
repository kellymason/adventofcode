def get_input
  return IO.read('input.txt').split(',').map{ |i| i.to_i }
end

# For #reasons, before starting we must
# replace input_array[1] with 12 and input_array[2] with 2
def restore_gravity_assist_program(input_array)
  input_array[1] = 12
  input_array[2] = 2
  return input_array
end

# takes in an array of integers
# outputs the result of all the conversions we're instructed to do
def start_this_ridiculous_process(gravity_program)
  (0...gravity_program.length - 1).step(4).each do |i|
    value1 = gravity_program[gravity_program[i+1]]
    value2 = gravity_program[gravity_program[i+2]]
    output_position = gravity_program[i+3]
    # opcodes
    case gravity_program[i]
    when 1
      gravity_program[output_position] = value1 + value2
    when 2
      gravity_program[output_position] = value1 * value2
    when 99
      puts "The answer is #{gravity_program[0]}"
      return
    else
      puts "Oops this opcode is unexpected"
    end
  end
end

def solve_part_1
  input_array = get_input
  starting_input = restore_gravity_assist_program(input_array)
  start_this_ridiculous_process(starting_input)
end

solve_part_1