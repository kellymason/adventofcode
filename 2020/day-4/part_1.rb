CORRECT_ANSWER = 222
REQUIRED_FIELDS = [
  "byr",
  "ecl",
  "eyr",
  "hcl",
  "hgt",
  "iyr",
  "pid",
]

# take input from input.txt
# return an array of objects representing individual passports
  # example:
  # [{ hcl: '#cfa07d',
  #   ecl: 'blu',
  #   hgt: '169cm',
  #   pid: 494407412,
  #   byr: 1936
  # }]
def get_formatted_input
  # get input as an array of strings representing passport info
  passport_strings_array = IO.read('input.txt').split("\n\n")

  # parse each passport string into a sub-array of field strings ex. ["pid:534453", "eyr:2024"]
  passport_fields_array = passport_strings_array.map do |passport_string|
    passport_string.split("\s")
  end
  # now we have an array of field string arrays, where each element is a passport
  # and each subelement is a string field ex. "byr:1985"
  formatted_passports = passport_fields_array.map do |passport_array|
    passport_array.map do |passport_string_field|
      passport_string_field.split(':')
    end.to_h
  end
  # puts "number of passports: #{formatted_passports.length}"
  return formatted_passports
end

def is_valid?(passport)
  passport_fields = passport.keys.select{|key| key != "cid" }.sort
  passport_fields == REQUIRED_FIELDS
end

def count_valid_passports
  passports = get_formatted_input
  puts passports.count{|p| is_valid?(p)}
end

count_valid_passports
