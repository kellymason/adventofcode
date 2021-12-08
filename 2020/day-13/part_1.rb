# get busses
# see which has the smallest remainder?
# multiply the bus number by the remainder
#  ...profit?
PUZZLE_INPUT = IO.readlines("input.txt")

# take in the string representing bus numbers
# return an array of the integers (with the x's removed)
def get_bus_numbers(input_string)
  input_string.select{|c| c != "x" }.map{|c| c.to_i }
end

# take in the departur  
def find_bus_to_take
end