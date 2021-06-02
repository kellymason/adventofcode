WRONG_ANSWERS = [
  817 #too low
]

CORRECT_ANSWER = 987

TEST_INPUT = [
  "FBBBBBBRRL",
  "BBFFFBBLRL",
  "FBFFBFFLRL",
  "FFBBBFBLRR",
  "FFBFBFFLLL",
  "BFBBBBFLLL",
  "FFBFFFFLLR",
  "FBBFBFBLRR",
  "BBBFFFFRRR",
  "BFBFFFBLLR",
  "BFFBBFBLLL",
  "FBBFFBFLRL",
  "FBBBFBFRLR",
  "BFBBBBBRRL",
  "BBFFBBFLLR",
]

def get_input
  input = IO.readlines('input.txt').map{ |l| l.chomp }
  return input
end

# returns an array containing the row number and column number
def get_seat_location(seat_string)
  row_directions = seat_string[0..6]
  column_directions = seat_string[7..9]
  min_row = 0
  max_row = 127
  seat_location = []
  row_directions.each_char do |dir|
    if dir == "F"
      max_row -= (max_row + 1 - min_row)/2
      # puts "#{dir}, new max_row: #{max_row}"
    else # dir equals "B"
      min_row += (max_row + 1 - min_row)/2
      # puts "#{dir}, new min_row: #{min_row}"
    end
  end
  if max_row == min_row 
    seat_location.push(min_row)
  else
    puts "Oh no! Min and max row don't match: #{min_row}, #{max_row}"
  end
  min_column = 0
  max_column = 7
  column_directions.each_char do |dir|
    if dir == "L"
      max_column -= (max_column + 1 - min_column)/2
      # puts "#{dir}, new max_column: #{max_column}"
    else # dir equals "R"
      min_column += (max_column + 1 - min_column)/2
      # puts "#{dir}, new min_column: #{min_column}"
    end
  end
  if min_column == max_column
    seat_location.push(min_column) 
  else
    puts "Oh no! Min and max column don't match: #{min_column}, #{max_column}"
  end
  return seat_location
end

# multiply the seat's row number by 8 and add the column number
def calculate_seat_id(seat_location)
  seat_location[0] * 8 + seat_location[1]
end

def find_max_seat_id
  seat_coords = get_input.map do |seat_string|
    get_seat_location(seat_string)
  end

  max_seat_id = 0
  # calculate the seat id for each ticket, keep track of the highest seat id
  seat_coords.each do |seat| 
    max_seat_id = calculate_seat_id(seat) if max_seat_id < calculate_seat_id(seat)
  end
  puts max_seat_id
end

find_max_seat_id
