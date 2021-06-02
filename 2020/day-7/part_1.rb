# NOTE: I cheated and looked at another solution for inspiration on this one ¯\_(ツ)_/¯

require "set"

CORRECT_ANSWER = 161
TEST_INPUT = [
  "light red bags contain 1 bright white bag, 2 muted yellow bags.",
  "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
  "bright white bags contain 1 shiny gold bag.",
  "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
  "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
  "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
  "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
  "faded blue bags contain no other bags.",
  "dotted black bags contain no other bags.",
]

def get_input
  IO.read('input.txt').split("\n")
end

# takes in an instruction and returns an array of colors - the first is the rule color, the rest are contained colors
#   ex 
#   input: "dotted salmon bags contain 2 dark lavender bags, 1 muted red bag, 1 vibrant magenta bag."
#   output: ["dotted_salmon", "dark lavendar", "muted red", "vibrant magenta"]
def parse_colors_from_string(str)
  colors_list = []
  colors = str.split(/(contain|\d|bags?)/).each do |el|
    el.strip!
    colors_list.push(el) if !el.match?(/(bag|contain|\d|\.|\,)/) && !el.empty?
  end
  colors_list
end

# take the raw input strings, build a hash of parents (keys) and their list of children (values)
# {
#   "bright white"=>["light red", "dark orange"], 
#   "muted yellow"=>["light red", "dark orange"],
#   "no other"=>["faded blue", "dotted black"]
# }
def create_bag_parents_object(input)
  bag_defs = {}
  bag_parents = Hash.new { |h, k| h[k] = [] }
  input.each do |line|
    colors_list = parse_colors_from_string(line)
    parent_bag, *children = colors_list
    bag_defs[parent_bag] = children
    for bag in children
      bag_parents[bag].push(parent_bag)
    end
  end
  bag_parents
end

# starting with shiny gold as the first target bag,
# add all parents of target bag to bags_containing_target
# add the parents of the target bag to bags_to_check so their parents can be checked later
def count_possible_parent_bags
  bag_parents = create_bag_parents_object(get_input)
  bags_containing_target = Set.new
  bags_to_check = ["shiny gold"]

  while !bags_to_check.empty?
      current_target_bag = bags_to_check.shift
      checked_bag_parents = bag_parents[current_target_bag]
      bags_containing_target = bags_containing_target.merge(checked_bag_parents)
      bags_to_check.concat(checked_bag_parents)
  end

  return bags_containing_target.length
end

puts count_possible_parent_bags
