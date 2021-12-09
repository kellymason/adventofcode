class DayEight
  def initialize(test: true)
    input_file = test ? "test_input.txt" : "input.txt"
    input = File.readlines(input_file, chomp: true)
    # an array consisting of nested arrays representing 4-digit output values
    # "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | dgacbe cefdb cefbgd gcbe"
    # [
      #   ["fdgacbe", "cefdb", "cefbgd", gcbe"],
      #   ["fdgacbe", "cefdb", "cefbgd", gcbe"],
      #   ["fdgacbe", "cefdb", "cefbgd", gcbe"],
      # ]
    @output_values = input.map{ |l| l.split("|").last.split(" ") }
    @signal_patterns = input.map{ |l| l.split("|").first.split(" ") }
  end

  # ones require 2 segments
  # fours require 4 segments
  # sevens require 3 segments
  # eights require 7 segments
  # go through @output_values, increment a counter if length is equal to one of these
  def count_ones_fours_sevens_and_eights
    counter = 0
    @output_values.flatten.each{ |value| counter += 1 if [2,3,4,7].include?(value.length) }
    puts counter
  end

  # determine which letter corresponds to which line segment
  # represent the line segments as positions 0 - 6, where 0 is top, moves clockwise, 6 is middle
  # find the segment letters that comprise the easy display_numbers (one, four, seven, eight)
  # all segments: 8
  # all segments - 1: 0,6,9
  # all segemnts - 2: 2,3,5
  # four segments: 4
  # three segments: 7
  # two segments: 1
  def key_with_one_four_seven_eight(line)
    key = Hash[(0..9).map { |num| [num, nil] }]
    remaining_nums = line.dup
    line.each do |pattern|
      letters = pattern.split("").uniq.sort
      case letters.length
      when 2
        key[1] = letters
        remaining_nums.delete(pattern)
      when 3
        key[7] = letters
        remaining_nums.delete(pattern)
      when 4
        key[4] = letters
        remaining_nums.delete(pattern)
      when 7
        key[8] = letters
        remaining_nums.delete(pattern)
      end
    end
    [remaining_nums, key]
  end

  # using what we have in the @key, try and figure out the other numbers

  def determine_other_numbers(line, key)
    line.each do |pattern|
      letters = pattern.split("").sort
      case letters.length
      when 5
        # possibilities: 2,3,5
        if key[1].all?{ |one_segment| letters.include?(one_segment) }
          key[3] = letters
        elsif (letters & key[1]).length == 1 && (letters & key[4]).length == 2
          key[2] = letters
        else 
          key[5] = letters
        end
        #  else its a 2
      when 6
        # possibilities: 0,6,9
        # if the letters don't contain the letters for 1, it's a 6
        # if the letters dont contain the letters for 4, it's a 0
        # else, 9
        if key[1] && !key[1].all?{ |one_segment| letters.include?(one_segment) }
          key[6] = letters
        elsif key[4] && !key[4].all?{ |four_segment| letters.include?(four_segment) }
          key[0] = letters
        else
          key[9] = letters
        end
      end
    end
    key
  end

  # given a key of segment mappings
  # apply to four-digit output and use to return the 4-digit integer representing the display number
  def get_display_values_for_line(line, key)
    # array representing four integer digits
    display_value = []
    line.each do |str|
      sorted_value_for_hash_comparison = str.split("").sort
      display_value.push(key.key(sorted_value_for_hash_comparison))
    end
    display_value.join.to_i
  end

  def sum_of_output_values
    numbers_to_sum = []
    @signal_patterns.each_with_index do |pattern_array, i|
      remaining_nums, key = key_with_one_four_seven_eight(pattern_array)
      determine_other_numbers(remaining_nums, key)
      numbers_to_sum.push(get_display_values_for_line(@output_values[i], key))
    end
    puts numbers_to_sum.sum
  end
end

# DayEight.new().count_ones_fours_sevens_and_eights
DayEight.new(test: false).sum_of_output_values