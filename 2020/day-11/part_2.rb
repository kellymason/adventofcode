WRONG_ANSWERS = 2178
TEST_INPUT = [
  "L.LL.LL.LL",
  "LLLLLLL.LL",
  "L.L.L..L..",
  "LLLL.LL.LL",
  "L.LL.LL.LL",
  "L.LLLLL.LL",
  "..L.L.....",
  "LLLLLLLLLL",
  "L.LLLLLL.L",
  "L.LLLLL.LL",
]

def get_adjacent_seat_values(matrix, row_number, seat_number)
  seat_matrix_snapshot = matrix.map{ |row| row.delete(".") }
  should_check_upper = row_number > 0
  should_check_left = seat_number > 0
  should_check_right = seat_number < matrix[row_number - 1].length - 1
  should_check_lower = row_number < matrix.length - 1


  adjacent_seats = []
  if row_number > 0
      adjacent_seats.push(seat_matrix_snapshot[row_number-1][seat_number-1]) if seat_number > 0
      adjacent_seats.push(seat_matrix_snapshot[row_number-1][seat_number])
      adjacent_seats.push(seat_matrix_snapshot[row_number-1][seat_number+1]) if seat_number < seat_matrix_snapshot[row_number - 1].length - 1
  end
    adjacent_seats.push(seat_matrix_snapshot[row_number][seat_number-1]) if seat_number > 0
    adjacent_seats.push(seat_matrix_snapshot[row_number][seat_number+1]) if seat_number < seat_matrix_snapshot[row_number - 1].length - 1
  if row_number < seat_matrix_snapshot.length - 1
    adjacent_seats.push(seat_matrix_snapshot[row_number+1][seat_number-1]) if seat_number > 0
    adjacent_seats.push(seat_matrix_snapshot[row_number+1][seat_number])
    adjacent_seats.push(seat_matrix_snapshot[row_number+1][seat_number+1]) if seat_number < seat_matrix_snapshot[row_number - 1].length - 1
  end
  puts "adjacent seats: ", adjacent_seats.compact.join("")
  return adjacent_seats.compact
end
#  L = empty, . = floor, # = occupied

def fill_seats(seat_matrix)
  seats_changed = false
  new_seat_matrix = []
  seat_matrix.each_with_index do |row, i|
    new_seat_matrix[i] = ""
    # for each seat, find all adjacent values and then decide whether to change the seat value.
    seat_matrix[i].chars.each_with_index do |seat, j|
      row_index = i
      seat_index = j
      # adjacent seats: upper_left, upper_middle, upper_right, left, right, lower_left, lower_middle, lower_right
      adjacent_seats = []
      adjacent_seat = ""
      # while the indices are in range and the adjacent value is a ".",
      # change the indices by 1 in the desired direction (i + 1 for down, i - 1 for up, j + 1 for right, j - 1 for left)
      8.times do
        while row_index >= 0 && row_index < seat_matrix.length - 1 && seat_index >= 0 && seat_index < row.length - 1 && adjacent_seat != "L" && adjacent_seat != "#"
          adjacent_seat = seat_matrix[row_index][seat_index]
          row_index, seat_index = case adjacent_seats.length
          when 0
            [row_index - 1, seat_index - 1]
          when 1
            [row_index - 1, seat_index]
          when 2
            [row_index - 1, seat_index + 1]
          when 3
            [row_index, seat_index - 1]
          when 4
            [row_index, seat_index + 1]
          when 5
            [row_index + 1, seat_index - 1]
          when 6
            [row_index + 1, seat_index]
          when 7
            [row_index + 1, seat_index + 1]
          end
        end
      end
      puts "adjacent seats: #{adjacent_seats}"
      if seat == "."
        new_seat_matrix[i] += "."
      elsif seat == "L"
        if adjacent_seats.count("#") == 0
          new_seat_matrix[i] += "#"
          seats_changed = true
        else
          new_seat_matrix[i] += "L"
        end
      elsif seat == "#"
        if adjacent_seats.count("#") >= 5
          new_seat_matrix[i] += "L"
          seats_changed = true
        else
          new_seat_matrix[i] += "#"
        end
      end
    end
  end
  return [new_seat_matrix, seats_changed]
end

def get_final_occupied_seat_count
  # seat_matrix = IO.readlines("input.txt")
  seat_matrix = TEST_INPUT
  seats_changed = true
  # while seats_changed == true do
  3.times do
    updated_seat_map = fill_seats(seat_matrix)
    seat_matrix = updated_seat_map[0]
    seats_changed = updated_seat_map[1]
  end
  return seat_matrix.flatten.join("").count("#")
end

puts get_final_occupied_seat_count
