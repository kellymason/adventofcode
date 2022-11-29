class DayNine

  def initialize(test: true)
    input_file = test ? "test_input.txt" : "input.txt"
    @input = File.readlines(input_file, chomp: true).map{ |l| l.split("").map(&:to_i)}
  end

  # Find low points
  # values that are lower than the values directly above, below, left, or right
  # sum them, adding 1 to each value
  # increment through each line
    # increment through each value
    # if it is a low point, add to array of low points
  # sum up low points + low points array length
  def solve_part_1
    low_points = []

    @input.each_with_index do |row, y|
      row.each_with_index do |element, x|
        above = y > 0 ? @input[y-1][x] : 10
        below = y < @input.length - 1 ? @input[y+1][x] : 10
        left = x > 0 ? row[x-1] : 10
        right = x < row.length - 1 ? row[x+1] : 10
        if element < [above, below, left, right].min
          low_points.push(element + 1)
        end
      end
    end
    puts low_points.sum
  end

  def collect_basins
    @input.each_with_index do |row, y|
      row.each_with_index do |element, x|
        indices_to_check_next = []
        # check value above
        # check value below
        # check left value
        # check right value
      end
    end
  end

  # collect items in a basin array
    # if the element == 9, it's an edge
    # check each surrounding element
      # if it's not an edge, add it to a list to check next
      # go through the list to check next
      # when the list is empty, return the basin
      # where do I define the basin?
  # find the three arrays with the largest length
  # multiply them
  def solve_part_2
    puts collect_basins.sort.max(3).reduce(:*)
  end
end

# DayNine.new(test: false).solve_part_1
DayNine.new().solve_part_2