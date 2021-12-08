class DaySeven

  INCORRECT_ANSWERS = ["answer is somewhere here", 95476248]
  def initialize(test: true)
    input_file = test ? "test_input.txt" : "input.txt"
    @crab_positions = File.readlines(input_file, chomp: true).first.split(",").map(&:to_i).sort
  end

  def distance_from_mean(mean, position)
    # get distance from crab to the meetup point
    distance = (position - mean).abs
    # get fuel needed by using summation to find fuel for each each step
    distance*(distance + 1)/ 2
  end

  def least_fuel_possible(part)
    # puts @crab_positions.inspect
    if part == 1
      median = (@crab_positions[(@crab_positions.length - 1) / 2] + @crab_positions[@crab_positions.length / 2]) / 2.0
    else
      # For part 2, use summation (n*(n+1/2) to get each crab's distance from the mean
      mean = (@crab_positions.reduce(0){ |a, b| a + b }.to_f / @crab_positions.count.to_f)
      fuel_needed_rounding_mean_down = @crab_positions.sum do |position|
        distance_from_mean(mean.to_i, position)
      end
      fuel_needed_rounding_mean_up = @crab_positions.sum do |position|
        distance_from_mean(mean.to_i + 1, position)
      end
      puts fuel_needed_rounding_mean_down, fuel_needed_rounding_mean_up
    end
  end
end

# DaySeven.new().least_fuel_possible(1)
DaySeven.new(test: false).least_fuel_possible(2)