# returns an array of 2 arrays
# each element represents directions of the tangled wire
# ex. [
  # ["R1003", "D430","L108","D570","R459","U7","L68","D232"],
  # ["L1003","U603","L675',"U828","R671","U925","R466"]
# ]
def get_input
  input = IO.readlines('input.txt').map { |line| line.split(',') }
  return input
end

# do you actually have to make a new array matrix?
# how do you represent moving up beyond the size of the matrix you've made? add to the array? maybe.
def trace_wire(input)
  grid = [[]]
  current_location = grid[0][0]

end

def solve_day_1
  wires = get_input
  wire_1 = trace_wire(wires[0])
  wire_2 = trace_wire(wires[1])
end

solve_day_1