class DayFive
  def initialize(test: true)
    input_file = test ? "test_input.txt" : "input.txt"
    # remove first two chars, split by ',' or " -> "
    # convert to array of [x1, y1, x2, y2]
    @all_lines = File.readlines(input_file, chomp: true).map{ |l| l.split(%r{#\s|,|\s->\s}).map(&:to_i) }
    @horizontal_and_vertical_lines = @all_lines.filter { |l| l[0] == l[2] || l[1] == l[3] }
  end

  def mark_lines_on_grid(lines_array)
    grid = [[]]
    lines_array.each do |coord_array|
      mark_line_on_grid(coord_array, grid)
    end
    grid
  end

  # ::facepalm::
  def mark_line_on_grid(coord_array, grid)
    x1 = coord_array[0]
    x2 = coord_array[2]
    y1 = coord_array[1]
    y2 = coord_array[3]
    x_change = (x2 - x1).abs
    y_change = (y2 - y1).abs

    # if horizontal, just increment the x coordinates in the y array
    if y_change == 0
      for i in 0..x_change do
        # puts "min of #{x1} and #{x2} is #{[x1,x2].min}"
        x_start = [x1,x2].min
        grid[y1] ||= []
        grid[y1][x_start + i] ||= 0
        grid[y1][x_start +i ] += 1 
      end
    elsif x_change == 0
      for i in 0..y_change do
        puts "min of #{y1} and #{y2} is #{[y1,y2].min}"
        y_start = [y1,y2].min
        grid[y_start + i] ||= []
        grid[y_start + i][x1] ||= 0
        grid[y_start + i][x1] += 1 
      end  
    else
      for i in 0..x_change do
         # x decreases, y decreaases
        if (x1 < x2 && y1 < y2)
          # slope is positive
          grid[y1 + i] ||= []
          grid[y1 + i][x1 + i] ||= 0
          grid[y1 + i][x1 + i] += 1 
        elsif (x1 > x2 && y1 > y2)
          grid[y1 - i] ||= []
          grid[y1 - i][x1 - i] ||= 0
          grid[y1 - i][x1 - i] += 1 
        elsif x1 > x2
          # x decreases, y increases
          grid[y1 + i] ||= []
          grid[y1 + i][x1 - i] ||= 0
          grid[y1 + i][x1 - i] += 1 
        else
          # x increases, y decreases
          grid[y1 - i] ||= []
          grid[y1 - i][x1 + i] ||= 0
          grid[y1 - i][x1 + i] += 1 
        end
      end
    end
    grid
  end

  def count_overlaps(consider_diagonals: true)
    lines_array = consider_diagonals ? @all_lines : @horizontal_and_vertical_lines
    puts mark_lines_on_grid(lines_array).flatten.compact.count{ |x| x > 1 }
  end
end

# DayFive.new().count_overlaps(consider_diagonals: false)
DayFive.new(test: false).count_overlaps