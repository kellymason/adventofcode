require_relative 'part_1.rb'

WRONG_ANSWERS = [
  602 # too low
]
CORRECT_ANSWER = 603
# get sorted list of seat ids, find one that's missing
def find_missing_seat_id
  seat_id_list = get_input.map{ |seat_string| calculate_seat_id(get_seat_location(seat_string)) }.sort

  non_consecutive_seats = []
  seat_id_list.each_with_index do |seat_id, index|
    if index != seat_id_list.length - 1 && seat_id != (seat_id_list[index + 1] - 1)
      non_consecutive_seats.push(seat_id)
    end
  end
  puts non_consecutive_seats
end

find_missing_seat_id
