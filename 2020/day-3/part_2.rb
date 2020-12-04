require_relative 'part_1'

# Use the same count_trees_land_on method to count trees for each
# given slope
# Add a new method that takes the tree counts for each slope and multiplies

slopes_from_instructions = [[1,1], [3,1], [5,1], [7,1], [1,2]]

def get_product_of_tree_counts(slopes_array)
  input = get_input
  numbers_to_multiply = slopes_array.map do |slope|
    count_trees_landed_on(input, slope[0], slope[1])
  end
  return numbers_to_multiply
end

puts get_product_of_tree_counts(slopes_from_instructions).inject(&:*)
