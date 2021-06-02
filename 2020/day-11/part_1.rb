CORRECT_ANSWER = 2281
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
  "L.LLLLL.LL"
]

#  L = empty, . = floor, # = occupied

def fill_seats(seat_matrix)
  seats_changed = false
  seat_matrix_snapshot = seat_matrix
  new_seat_matrix = []
  seat_matrix.each_with_index do |row, i|
    new_seat_matrix[i] = ""
    row.chars.each_with_index do |seat, j|
      adjacent_seats = []
      if i > 0
        if j > 0
          adjacent_seats.push(seat_matrix_snapshot[i-1][j-1])
        end
        adjacent_seats.push(seat_matrix_snapshot[i-1][j])
        if j < row.length - 1
          adjacent_seats.push(seat_matrix_snapshot[i-1][j+1])
        end
      end
      if j > 0
        adjacent_seats.push(seat_matrix_snapshot[i][j-1])
      end
      if j < row.length - 1
        adjacent_seats.push(seat_matrix_snapshot[i][j+1])
      end
      if i < seat_matrix.length - 1
        if j > 0
          adjacent_seats.push(seat_matrix_snapshot[i+1][j-1])
        end
        adjacent_seats.push(seat_matrix_snapshot[i+1][j])
        if j < row.length - 1
          adjacent_seats.push(seat_matrix_snapshot[i+1][j+1])
        end
      end
      if seat == "L"
        if adjacent_seats.compact.none?("#")
          new_seat_matrix[i] += "#"
          seats_changed = true
        else
          new_seat_matrix[i] += "L"
        end
      elsif seat == "#"
        if adjacent_seats.compact.count("#") >= 4
          new_seat_matrix[i] += "L"
          seats_changed = true
        else
          new_seat_matrix[i] += "#"
        end
      else
        new_seat_matrix[i] += "."
      end
    end
  end
  return [new_seat_matrix, seats_changed]
end

def get_final_occupied_seat_count
  seat_matrix = IO.readlines("input.txt")
  seats_changed = true
  while seats_changed == true do
    updated_seat_map = fill_seats(seat_matrix)
    seat_matrix = updated_seat_map[0]
    seats_changed = updated_seat_map[1]
  end
  return seat_matrix.flatten.join("").count("#")

end

puts get_final_occupied_seat_count
