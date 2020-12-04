WRONG_ANSWERS = [
  5,
  72,
  73,
  189
]

CORRECT_ANSWERs = [
  195, # part 1
  3772314000, # part 2
]
# saves an array containing each line of input.txt
def get_input
  input = IO.readlines('input.txt').map{ |l| l.chomp }
  return input
end

# traverse the input array
  # if the current_x value is '#', increment the tree counter
  # increment x by x_step to loop through possible x coordinates
def count_trees_landed_on(input, x_step=3, y_step=1)
  current_x = 0
  current_y = 0
  tree_count = 0
  while current_y < input.length do 
    tree_count += 1 if input[current_y][current_x] == '#'
    current_x += x_step
    current_x = current_x % input[0].length if current_x >= input[0].length
    current_y += y_step
  end
  return tree_count
end

count_trees_landed_on(get_input)
