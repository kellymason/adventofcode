# Each line in input.txt consists of
#  5 integers, 3 spaces, 5 integers
#  ex: 11111   22222
TEST_INPUT = [
  "3   4
  4   3
  2   5
  1   3
  3   9
  3   3"
]
# Create an array representing the first column's values
# Create an array representing the second column's values
# Iterate through each line,
# save the first 5 chars as an integer to list1,
# save the second 5 chars as an integer to list2
def get_input
  list1 = []
  list2 = []
  lists = IO.readlines("input.txt").each do |l|
    list1 << l[0..4].to_i
    list2 << l[8..12].to_i
  end
  [list1, list2]
  # steps = TEST_INPUT
end

# solve part 1
def get_difference
  puts "solving part 1!"
  list1 = get_input[0].sort
  list2 = get_input[1].sort
  diff_sum = 0
  for i in 0...list1.length
    diff_sum += (list1[i] - list2[i]).abs
  end
  puts "difference: #{diff_sum}"
end

# solve part 2
# create a counter
# iterate through list 1 
# call count on list 1 int
# multiply element by count result
# add output to counter
def get_similarity_score
  puts "solving part 2!"
    similarity_score = 0
    list1 = get_input[0].sort
    list2 = get_input[1].sort
    # p "lists: #{[list1, list2]}"
    list1.each do |location_id|
      list2_frequency = list2.count(location_id)
      similarity_score += location_id*list2_frequency
    end
    puts "similarity score: #{similarity_score}"
end

get_difference
get_similarity_score