class DayTenPartTwo
  def initialize(test: true)
    input_file = test ? "test_input.txt" : "input.txt"
    @input = IO.readlines(input_file).map{|l| l.to_i}.sort
    # puts "input: #{@input.inspect}"
  end

  # takes in input as a sorted array of ints
  # maps the list of valid next steps for each adapter
  # goes through each value of each next step
  # def count_combos
  #   combo_count = 0
  #   current_range = []
  #   @input.each_with_index do |joltage, i|
  #     current_combo_count = 0
  #     if i > 0 && joltage - @input[i-1] == 3
  #       # puts "#{joltage} - #{@input[i-1]} is 3"
  #       # count the combos of current range,
  #       # increment the combo_count, 
  #       if current_range.length > 1
  #         (1).upto(current_range.length) do |i|
  #           puts "combos to add: #{current_range.combination(i).to_a}"
  #           current_combo_count += (current_range.combination(i).to_a.count - 1)
  #           combo_count += current_combo_count
  #         end
  #       end
  #       # then clear the current range
  #       current_range = []
  #     else
  #       current_range.push(joltage)
  #       puts "current_range: #{current_range}"
  #     end
  #   end
  #   return combo_count
  # end

  # add zero to the beginning of the array to represent the outlet
  # Change the data to look something like this:
  # {
  #   0: [1],
  #   1: [4],
  #   4: [5,6,7],
  #   5: [6,7],
  # }

    # iterate through the sorted joltages
    # for each joltage value, save a list of valid next adapters
    # 

  def fill_in_hash
    @joltages_hash = @input.unshift(0).to_h { |k| [k, nil] }
    puts @joltages_hash.inspect
    # for each joltage in our input list,
    # set the joltage as a key and an array of the possible next values as the value
    adapter_count = @input.length
    @input.each_with_index do |joltage, i|
      if i == adapter_count - 1
        # last adapter
        @joltages_hash.delete(joltage)
        return @joltages_hash
      elsif i == adapter_count - 2
        # second to last adapter, only one step from here
        possible_next_joltages = [@input[i + 1]]
      elsif i == adapter_count - 3
        possible_next_joltages = [@input[i+1], @input[i+2]].select{ |higher_joltage| (higher_joltage - joltage) <= 3 }
      else
        possible_next_joltages =[@input[i+1],@input[i+2],@input[i+3]].select{ |higher_joltage| (higher_joltage - joltage) <= 3 }
        # puts "possible next adapters: #{possible_next_joltages}"
      end
      @joltages_hash[joltage] = possible_next_joltages
    end
  end

# todo: count number of values each key has, do a factorial
  def count_combos
    puts @joltages_hash.values.inspect
    choice_points = @joltages_hash.values.filter{ |val| val.length > 1 }
    # array of values greater than 1 representing how many choices there are for the adapter
    choice_points.sum{ |choice_count| (1..choice_count).inject(:*) }
  end

  def get_final_answer
    fill_in_hash
    puts count_combos
  end
end

puts DayTenPartTwo.new().get_final_answer
