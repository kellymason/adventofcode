class DayThreePartOne
  TEST_INPUT = ["00100","11110","10110","10111","10101","01111","00111","11100","10000","11001","00010","01010"]

  def initialize(test = false)
    # define @input as an array of strings representing each binary number
    @input = test ? TEST_INPUT : File.readlines("input.txt", chomp: true)
  end

  # avoid ruby converting the inputs to decimal before we can iterate
  def test_input_format
    @input.first.class
  end

  # take in the input,
  # use transpose to group each digits place
  # check most frequently occurring value
  # reconstruct binary number as a string
  def binary_gamma_rate
    gamma_rate_string = ""
    column_arrays = @input.map{ |line| line.split("")}.transpose
    # go through each digits place and see whether there are more 1s or 0s
    column_arrays.each do |column|
      counts = column.tally
      next_num = counts["0"] > counts["1"] ? "0" : "1"
      gamma_rate_string += next_num
    end
    gamma_rate_string
  end

  def binary_epsilon_rate(gamma_rate_string)
    rate = ""
    gamma_rate_string.each_char do |c| 
      if c == "0"
        rate += "1"
      else
        rate += "0"
      end
    end
    rate
  end

  def solve_part_1
    # puts "first few inputs: #{@input.take(10)}"
    gamma_rate = binary_gamma_rate
    puts "gamma rate: #{gamma_rate}, decimal: #{gamma_rate.to_i(2)}"
    epsilon_rate = binary_epsilon_rate(gamma_rate)
    puts "epsilon rate: #{epsilon_rate}, decimal: #{epsilon_rate.to_i(2)}"
    power_consumption = gamma_rate.to_i(2) * epsilon_rate.to_i(2)
    puts power_consumption
  end
end

DayThreePartOne.new().solve_part_1