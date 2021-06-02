
CORRECT_ANSWER = 30899
TEST_INPUT = [
  "shiny gold bags contain 2 dark red bags.",
  "dark red bags contain 2 dark orange bags.",
  "dark orange bags contain 2 dark yellow bags.",
  "dark yellow bags contain 2 dark green bags.",
  "dark green bags contain 2 dark blue bags.",
  "dark blue bags contain 2 dark violet bags.",
  "dark violet bags contain no other bags.",
]

def get_input
  IO.read('input.txt').split("\n")
end

# constructs a hash of parent keys and their contents
#   ex 
#   input: "dotted salmon bags contain 2 dark lavender bags, 1 muted red bag, 1 vibrant magenta bag."
#   output: {"dotted_salmon":  [{count: 2, name: "dark lavendar"}, {count: 1, name: "muted red"}, {count: 1, name: "vibrant magenta"}]}
def construct_parent_child_object(input_array)
  parent_child_object = {}
  input_array.each do |line|
    split_sentence = line.split(" contain ")
    parent_bag = split_sentence[0].split(" ")[0..1].join(" ")
    if split_sentence[1] == "no other bags."
      parent_child_object[parent_bag] = []
      next
    end
    child_bag_strings = split_sentence[1].split(",")
    children = []
    child_bag_strings.each do |string|
      arr = string.split(" ")
      arr.delete_at(-1)
      count = arr.shift.to_i
      name = arr.join(" ")
      children.push({ :name => name, :count => count })
    end
    parent_child_object[parent_bag] = children
  end
  return parent_child_object
end

# starting with shiny gold, add each child to the list to count
# 
def count_shiny_gold_bag_contents
  input = get_input
  bag_count = 0
  bags_to_check = ["shiny gold"]
  parent_child_object = construct_parent_child_object(input)
  while !bags_to_check.empty?
    target_bag = bags_to_check.shift
    for child_bag in parent_child_object[target_bag]
      bag_count += child_bag[:count]
      bags_to_check += [child_bag[:name]] * child_bag[:count]
    end
  end
  bag_count
end

# puts count_shiny_gold_bag_contents
puts count_shiny_gold_bag_contents
