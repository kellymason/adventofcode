CORRECT_ANSWER = 140
FIELD_RULES = {
  byr: {digits: 4, min: 1920, max: 2002},
  iyr: {digits: 4, min: 2010, max: 2020},
  eyr: {digits: 4, min: 2020, max: 2030},
  hcl: { regex: /#[0-9a-f]{6}/},
  ecl: {regex: /(amb|blu|brn|gry|grn|hzl|oth)/},
  pid: {digits: 9},
  hgt: { regex: /(1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in)/},
}

# parse input.txt as an array of passport objects containing key/value pairs representing each field
# ex {:byr=>"1985", :eyr=>"2021", :iyr=>"2011", :hgt=>"175cm", :pid=>"163069444", :hcl=>"#18171d"}
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
    end.to_h.transform_keys(&:to_sym)
  end

  return formatted_passports
end

# return false if any criteria not met
def each_field_valid?(passport_object)
  FIELD_RULES.each_pair do |field, rules|
    return false if !passport_object.has_key?(field)
    return false if rules.has_key?(:digits) && rules[:digits] != passport_object[field].length
    return false if rules.has_key?(:min) && (passport_object[field].to_i < rules[:min] || passport_object[field].to_i > rules[:max])
    return false if rules.has_key?(:regex) && !passport_object[field].match?(rules[:regex])
  end
end

def valid_password_count
  input = get_formatted_input
  puts input.count{|passport| each_field_valid?(passport)}
end

valid_password_count
