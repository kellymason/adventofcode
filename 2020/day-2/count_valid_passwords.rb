WRONG_ANSWERS = [
  1000, # too high
]

CORRECT_ANSWER = 515
# takes in each line of input.txt
# parses as array
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
#  sets first int as min
#  second int as max,
#  next value as search item
# increments counter if count of search item is not within range
# returns count
def count_valid_passwords
  password_array = get_input
  num_valid_passwords = password_array.count do |password|
    criteria_count = password[3].count(password[2]).to_i
    criteria_count >= password[0].to_i && criteria_count <= password[1].to_i
  end
  puts num_valid_passwords
end

count_valid_passwords
