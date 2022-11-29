class DayThreePartTwo
  TEST_INPUT = ["00100","11110","10110","10111","10101","01111","00111","11100","10000","11001","00010","01010"]
  INCORRECT_ANSWERS = []

  def initialize(test = false)
    # define @input as an array of strings representing each binary number
    @input = test ? TEST_INPUT : File.readlines("input.txt", chomp: true).map(&:strip)
  end

  # take a list of strings representing the most common value for each bit position
  # iterate through each digits place, tallying the 1's and 0's
  # remove strings whose current digit place does not contain the max value
  # repeat with the newly filtered list 
  # stop after the last digits place
  def filter_oxygen_generator_ratings(input)
    filter_list = input.dup
    for i in 0...filter_list.first.length do
      most_common_value = most_common_value(filter_list, i)
      filter_list.keep_if{ |binary_string| binary_string[i] == most_common_value }
      return filter_list[0] if filter_list.length == 1
    end
    filter_list
  end

  # dont forget to keep values with a "0" if "0" and "1" are equally common
  def filter_co2_scrubber_ratings(input)
    filter_list = input.dup
    for i in 0...filter_list.first.length do
      least_common_value = least_common_value(filter_list, i)
      filter_list.keep_if{ |binary_string| binary_string[i] == least_common_value }
      return filter_list[0] if filter_list.length == 1
    end
  end

  # for a given bit position, return the most common value
  # need to call this separately for each bit position
  def most_common_value(str_list, bit_position)
    output = []
    zero_counter = 0
    str_list.each{ |binary_string| zero_counter += 1 if binary_string[bit_position] == "0" }
    max_value = zero_counter > str_list.length / 2 ? "0" : "1"
    max_value
  end

  def least_common_value(str_list, bit_position)
    output = []
    zero_counter = 0
    str_list.each{ |binary_string| zero_counter += 1 if binary_string[bit_position] == "0" }
    if zero_counter == str_list.length / 2
      min_value = "0"
    else
      min_value = zero_counter > str_list.length / 2 ? "1" : "0"
    end
    min_value
  end

  def life_support_rating
    oxygen_generator_rating = filter_oxygen_generator_ratings(@input)
    co2_scrubber_rating = filter_co2_scrubber_ratings(@input)
    puts "oxygen_generator_rating: #{oxygen_generator_rating}"
    puts "co2_scrubber_rating: #{co2_scrubber_rating}"
    puts oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)
  end

end

DayThreePartTwo.new().life_support_rating