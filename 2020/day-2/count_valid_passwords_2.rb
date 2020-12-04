WRONG_ANSWERS = [
  408, # too low
  738, # too high
]

CORRECT_ANSWER = 711

# takes in each line of input.txt
# parses as array of position1, position2, search_item, search_string
# ex. input: 6-8 s: svsssszslpsp
# ex. output: [6,8,'s','svsssszslpsp']
def get_input
  lines = File.readlines('input.txt').map do |l|
    line_array = l.split
    line_array[0] = line_array[0].split('-')
    line_array[1].chop!
    line_array.flatten!
    line_array
  end
end

# iterates over formatted input array
# increments counter if count of search criteria is not met
# returns count
def count_valid_passwords
  password_array = get_input
  num_valid_passwords = password_array.count do |password|
    search_item = password[2]
    search_string = password[3]
    char_at_first_position = search_string[password[0].to_i-1]
    char_at_second_position = search_string[password[1].to_i-1]

    # add to count if the digit at either the first position 
    # or second position equals the search item (not both)
    (search_item == char_at_first_position && search_item != char_at_second_position) ||
    (search_item != char_at_first_position && search_item == char_at_second_position)
  end
  puts num_valid_passwords
end

count_valid_passwords
