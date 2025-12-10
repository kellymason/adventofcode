TEST_INPUT = [
  "..@@.@@@@.",
  "@@@.@.@.@@",
  "@@@@@.@.@@",
  "@.@@@@..@.",
  "@@.@@@@.@@",
  ".@@@@@@@.@",
  ".@.@.@.@@@",
  "@.@@@.@@@@",
  ".@@@@@@@@.",
  "@.@.@@@.@.",
]

# Read test input
# Save as an array of strings containing "." and "@"
def get_input
  ARGV[1] == "test" ? TEST_INPUT : File.readlines("input.txt", chomp: true)
end

# Part 1 logic
# First idea:
#  iterate through each one, check each item around it, increment a counter
def count_accessible_rolls_once(input)
  accessible_roll_count = 0
  input.each_with_index do |line, row_number|
    line.chars.each_with_index do |roll, column_number|
      next if roll != "@"
      adjacent_rolls = 0
      # check row above
      if row_number != 0
        if column_number != 0
          if input[row_number - 1][column_number - 1] == "@"
            adjacent_rolls += 1
          end
        end
         adjacent_rolls += 1 if input[row_number - 1][column_number] == "@"
         if column_number != line.length - 1
          adjacent_rolls += 1 if input[row_number - 1][column_number + 1] == "@"
         end
      end
      # check left
      if column_number != 0
        adjacent_rolls += 1 if input[row_number][column_number - 1] == "@"
      end
      # check right
      if column_number != line.length - 1
        adjacent_rolls += 1 if input[row_number][column_number + 1] == "@"
      end
      # check row below
      if row_number != input.length - 1
        if column_number != 0
          adjacent_rolls += 1 if input[row_number + 1][column_number - 1] == "@"
        end
         adjacent_rolls += 1 if input[row_number + 1][column_number] == "@"
         if column_number != line.length - 1
          adjacent_rolls += 1 if input[row_number + 1][column_number + 1] == "@"
         end
      end
     if adjacent_rolls < 4
       accessible_roll_count += 1
     end
    end
  end
  puts accessible_roll_count
end

# Part 2 helper
def count_and_remove_accessible_rolls(input)
  accessible_roll_count = 0
  input.each_with_index do |line, row_number|
    line.chars.each_with_index do |roll, column_number|
      next if roll != "@"
      adjacent_rolls = 0
      # check row above
      if row_number != 0
        if column_number != 0
          if input[row_number - 1][column_number - 1] == "@"
            adjacent_rolls += 1
          end
        end
         adjacent_rolls += 1 if input[row_number - 1][column_number] == "@"
         if column_number != line.length - 1
          adjacent_rolls += 1 if input[row_number - 1][column_number + 1] == "@"
         end
      end
      # check left
      if column_number != 0
        adjacent_rolls += 1 if input[row_number][column_number - 1] == "@"
      end
      # check right
      if column_number != line.length - 1
        adjacent_rolls += 1 if input[row_number][column_number + 1] == "@"
      end
      # check row below
      if row_number != input.length - 1
        if column_number != 0
          adjacent_rolls += 1 if input[row_number + 1][column_number - 1] == "@"
        end
         adjacent_rolls += 1 if input[row_number + 1][column_number] == "@"
         if column_number != line.length - 1
          adjacent_rolls += 1 if input[row_number + 1][column_number + 1] == "@"
         end
      end
     if adjacent_rolls < 4
      input[row_number][column_number] = "."
       accessible_roll_count += 1
     end
    end
  end
  [accessible_roll_count, input]
end

def count_accessible_rolls_with_removal(input)
  accessible_roll_count = 0
  grid = input
  loop do
    accessible_rolls_this_turn, grid = count_and_remove_accessible_rolls(grid)
    accessible_roll_count += accessible_rolls_this_turn
    break if accessible_rolls_this_turn == 0
  end
  puts accessible_roll_count
end

def solve(part)
  if ARGV[0] == "1"
  count_accessible_rolls_once(get_input) # part 1
  elsif ARGV[0] == "2"
  count_accessible_rolls_with_removal(get_input) # part 2
  else
    puts "OOPS! you put #{ARGV[0]}, expecting 1 or 2"
  end
end

solve(ARGV[0])