CORRECT_ANSWER = 2450
TEST_INPUT = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]

def get_input
  IO.readlines("input.txt").map{|l| l.to_i}.sort!
end

# takes in input as a sorted array of ints
# maps the list of valid next steps for each adapter
# goes through each value of each next step
def count_combos(input)
  combo_count = 0
  current_range = []
  input.each_with_index do |joltage, i|
    if i > 0 && joltage - input[i-1] == 3
      # puts "#{joltage} - #{input[i-1]} is 3"
      # count the combos of current range,
      # increment the combo_count, 
      if current_range.length > 1
        (1).upto(current_range.length) do |i|
          puts "combos to add: #{current_range.combination(i).to_a}"
          current_combo_count += (current_range.combination(i).to_a.count - 1)
          combo_count += current_combo_count
        end
      end
      # then clear the current range
      current_range = []
    else
      current_range.push(joltage)
      puts "current_range: #{current_range}"
    end
  end
  return combo_count
end

def get_final_answer
  input = TEST_INPUT.sort
  count_combos(input)
end

puts get_final_answer
